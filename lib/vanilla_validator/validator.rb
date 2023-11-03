module VanilaValidator
	class Validator
		attr_accessor :input, :contracts, :options, :errors, :validated

		def initialize(input, contracts, options = {})
			@input = input
      @contracts = contracts
      @options = options
      @errors = {}
      @validated = init_clone
		end

		def call
			contracts.each do |attribute, contract|
	      value = ValueExtractor.get(input, attribute)
	      rules = RuleParser.parse(contract)

	      rule_results = rules.map do |rule|
	        validator(attribute, value, rule)
	      end

	      invalid_rules = rule_results.reject(&:valid?)
	      if invalid_rules.empty?
	        data_set(validated, attribute, value)
	      else
	        invalid_rules.each do |result|
	          add_failure(attribute, result.failure_message)
	        end
	      end
	    end

	    validated = delete_missing_values(validated)

    	OpenStruct.new(errors: errors, valid: valid?, validated: validated)
		end

		def init_clone
	    new_input = input.dup
	    nullify_values(new_input)
	  end

	  def nullify_values(hash)
	    hash.each do |key, value|
	      if value.is_a?(Hash)
	        nullify_values(value)
	      elsif value.is_a?(Array)
	        value.each { |item| nullify_values(item) if item.is_a?(Hash) }
	      else
	        hash[key] = '__missing__'
	      end
	    end
	  end

	  def validator(attribute, value, rule)
	    Rules.const_get(rule.name.camelize).new(attribute, value, rule.parameters)
	  end

	  def data_set(array, key, value)
	    keys = key.split(".")
	    last_key = keys.pop

	    target = keys.reduce(array) do |hash, k|
	      case k
	      when "*"
	        hash.last ||= {}
	        hash.last
	      else
	        hash[k] ||= {}
	        hash[k]
	      end
	    end

	    if last_key == "*"
	      target << value
	    else
	      target[last_key] = value
	    end

	    array
	  end

	  def get_input
	    input
	  end

	  def errors
	    messages
	  end

	  def valid?
	    messages.empty?
	  end

	  def add_failure(attribute, message)
	    messages[attribute] ||= []
	    messages[attribute] << message
	  end

	  def delete_missing_values(hash)
	    hash.each do |k, v|
	      if v == '__missing__'
	        hash.delete(k)
	      elsif v.kind_of?(Array)
	        hash[k] = v.reject { |item| item == '__missing__' }
	      end
	    end
	    return hash
	  end


	end
end
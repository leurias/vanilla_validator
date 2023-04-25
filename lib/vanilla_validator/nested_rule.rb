module VanillaValidator
  class NestedRule
    attr_accessor :attribute, :action, :parameters, :attribute_value

    SUPPORTED_METHODS = %w[present blank nil in not_in gt lt eq not_eq gte lte truthy falsy boolean].freeze
    DEFAULT_ACTION = 'eq'

    def initialize(input, params)
      @attribute = params[0]
      if params.count == 2
        @action = 'eq'
      else
        @action = params[1]
      end
      @parameters = normalize(params[@action == DEFAULT_ACTION ? 1..-1 : 2..-1])
      @attribute_value = ValueExtractor.get(input, @attribute)
    end

    private

    def normalize(parameters)
      parameters.map do |parameter|
        case parameter.downcase
        when 'true' then true
        when 'false' then false
        when /\A\d+\z/ then parameter.to_i
        when /\A\d+\.\d+\z/ then parameter.to_f
        else parameter
        end
      end
    end
  end
end
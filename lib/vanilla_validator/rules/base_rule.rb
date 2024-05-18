module VanillaValidator
	module Rules
		class BaseRule
			attr_accessor :attribute, :value, :parameters

		  def initialize(attribute, value, parameters)
		  	@attribute, @value, @parameters = attribute, value, parameters
		  end

		  private

		  def required?
		  	Rules::Required.new(attribute, value, parameters).valid?
			end

			def __(key, **args)
				full_key = "vanilla_validator.#{key}"
				I18n.t(full_key, **args)
			end
		end
	end
end
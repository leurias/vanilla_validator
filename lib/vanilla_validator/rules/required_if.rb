module VanillaValidator
	module Rules
		class RequiredIf < BaseRule
			def valid?
				other_rule = VanillaValidator::Rules::OtherRule.(VanillaValidator.raw_input, parameters)

				other_rule.klass.valid? && required?
			end

			def failure_message
	      I18n.t("required_if", attribute: attribute, other: parameters[0].to_i, value: value)
	    end
		end
	end
end
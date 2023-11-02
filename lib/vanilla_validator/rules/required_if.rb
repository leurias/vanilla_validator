module VanillaValidator
	module Rules
		class RequiredIf < BaseRule
			def valid?
				nested_rule = VanillaValidator::NestedRule.new(VanillaValidator.get_input, parameters)
				rule = Rules.const_get(nested_rule.action.camelize).new(nested_rule.attribute, nested_rule.attribute_value, nested_rule.parameters)
				rule.valid?
			end

			def failure_message
				# TODO
	      I18n.t("required_if", attribute: attribute, other: parameters[0].to_i)
	    end
		end
	end
end
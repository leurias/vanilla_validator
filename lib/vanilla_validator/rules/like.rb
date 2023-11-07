module VanillaValidator
	module Rules
		class Like < BaseRule
			def valid?
				other_value = ValueExtractor.get(VanillaValidator.raw_input, parameters[0])
				value == other_value
			end

			def failure_message
	      I18n.t('like', attribute: attribute, other_attribute: parameters[0])
	    end
		end
	end
end
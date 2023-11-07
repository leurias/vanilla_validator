module VanillaValidator
	module Rules
		class Min < BaseRule
			def valid?
				value.length >= parameters[0].to_i
			end

			def failure_message
	      I18n.t("min.string", attribute: attribute, min: parameters[0].to_i)
	    end
		end
	end
end
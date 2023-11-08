module VanillaValidator
	module Rules
		class Numeric < BaseRule
			def valid?
				return true if value.kind_of?(Numeric)
  			!!(Integer(value) rescue Float(value)) rescue false
			end

			def failure_message
	      I18n.t("numeric", attribute: attribute)
	    end
		end
	end
end
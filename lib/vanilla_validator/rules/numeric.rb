module VanillaValidator
	module Rules
		class Numeric < BaseRule
			def valid?
				value =~ /\A[-+]?[0-9]*\.?[0-9]+\Z/
			end

			def failure_message
	      I18n.t("numeric", attribute: attribute)
	    end
		end
	end
end
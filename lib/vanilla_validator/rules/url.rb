module VanillaValidator
	module Rules
		class Url < BaseRule
			def valid?
				value =~ URI::regexp
			end

			def failure_message
	      I18n.t('url', attribute: attribute)
	    end
		end
	end
end
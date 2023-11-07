module VanillaValidator
	module Rules
		class Before < BaseRule
			def valid?
				::Date.parse(value, '%Y-%m-%d') < ::Date.parse(parameters[0], '%Y-%m-%d')
			end

			def failure_message
	      I18n.t('after', attribute: attribute, date: parameters[0])
	    end
		end
	end
end
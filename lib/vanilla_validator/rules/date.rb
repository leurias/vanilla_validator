module VanillaValidator
	module Rules
		class Date < BaseRule
			def valid?
				begin
			    Date.strptime(value, '%Y-%m-%d')
			    true
			  rescue ArgumentError
			    false
			  end
			end

			def failure_message
	      I18n.t('date', attribute: attribute)
	    end
		end
	end
end
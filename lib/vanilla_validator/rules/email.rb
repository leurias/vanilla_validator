module VanillaValidator
	module Rules
		class Email < BaseRule
			def valid?
				required && value =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
			end

			def failure_message
	      I18n.t('email', attribute: attribute)
	    end
		end
	end
end
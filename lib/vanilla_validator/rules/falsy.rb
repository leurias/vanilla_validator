module Rules
	class Falsy < BaseRule
		def valid?
			acceptable = ['no', 'off', '0', 0, false, 'false']
			required && acceptable.include?(value)
		end

		def failure_message
      I18n.t('falsy', attribute: attribute)
    end
	end
end
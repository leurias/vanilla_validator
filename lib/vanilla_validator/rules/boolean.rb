module Rules
	class Boolean < BaseRule
		def valid?
			!!value == value
		end

		def failure_message
      I18n.t('boolean', attribute: attribute)
    end
	end
end
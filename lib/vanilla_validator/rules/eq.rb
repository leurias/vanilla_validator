module Rules
	class Eq < BaseRule
		def valid?
			value == parameters[0].to_i
		end

		def failure_message
      I18n.t("eq", attribute: attribute, value: parameters[0].to_i)
    end
	end
end
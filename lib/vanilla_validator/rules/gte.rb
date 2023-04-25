module Rules
	class Gte < BaseRule
		def valid?
			value >= parameters[0].to_i
		end

		def failure_message
      I18n.t("gte.numeric", attribute: attribute, value: parameters[0].to_i)
    end
	end
end
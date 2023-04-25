module Rules
	class Max < BaseRule
		def valid?
			value.length <= parameters[0].to_i
		end

		def failure_message
      I18n.t("max.string", attribute: attribute, max: parameters[0].to_i)
    end
	end
end
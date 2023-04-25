module Rules
	class Like < BaseRule
		def valid?
			other_value = VanillaValidator::ValueExtractor.get(VanillaValidator.get_input, parameters[0])
			value.eql?(other_value)
		end

		def failure_message
      I18n.t('like', attribute: attribute, other_attribute: parameters[0])
    end
	end
end
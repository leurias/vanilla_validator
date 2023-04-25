module VanillaValidator
	class MyValidation

		def self.passes(attribute, value)
			false
		end

		def self.message
			'a custom validation %{attribute}'
		end

	end
end
module VanillaValidator
	# Rule represents a validation rule with a name and optional parameters.
	class Rule
		attr_accessor :name, :parameters

		def initialize(name, parameters)
			@name, @parameters = name, parameters
		end
	end
end
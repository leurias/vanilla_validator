module VanillaValidator
	class Rule
		attr_accessor :name, :parameters

		def initialize(name, parameters)
			@name, @parameters = name, parameters
		end
	end
end
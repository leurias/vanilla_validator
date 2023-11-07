module VanillaValidator
	module Rules
		class BlockRule

			attr_accessor :message

			def initialize(attribute, value, block)
				block.call(attribute, value, ->(msg){ message = msg })
			end
		end
	end
end
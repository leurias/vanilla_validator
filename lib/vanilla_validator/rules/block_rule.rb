module VanillaValidator
	module Rules
		class BlockRule < BaseRule

			attr_accessor :message

			def valid?
				block = parameters
				block.call(attribute, value, ->(msg){ self.message = msg })
				
				message.nil? ? true : false
			end

			def failure_message
	      message
	    end
		end
	end
end
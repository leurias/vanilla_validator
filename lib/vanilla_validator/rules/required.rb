module VanillaValidator
  module Rules
  	class Required < BaseRule
  		def valid?
  			if value.nil?
          return false
        elsif value.class == String && value.strip == ''
          return false
        elsif value.class == Array && value.count < 1
          return false
        end

        return true
  		end

      def failure_message
        I18n.t('required', attribute: attribute)
      end
  	end
  end
end
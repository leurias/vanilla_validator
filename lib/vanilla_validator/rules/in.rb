module VanillaValidator
  module Rules
    class In < BaseRule
      def valid?
        parameters.include? value.to_s
      end

      def failure_message
        I18n.t('in', attribute: attribute)
      end
    end
  end
end
module VanillaValidator
  module Rules
    class Alpha < BaseRule
      def valid?
        value.is_a? String
      end

      def failure_message
        I18n.t("alpha", attribute: attribute)
      end
    end
  end
end
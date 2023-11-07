module VanillaValidator
  module Rules
    class OtherRule
      attr_accessor :name, :attribute, :value, :parameters, :klass

      DEFAULT_RULE_NAME = 'eq'.freeze

      def initialize(input, term_array)
        self.attribute = term_array[0]
        self.name = term_array.length == 2 ? DEFAULT_RULE_NAME : term_array[1]
        self.parameters = self.normalize(term_array[name == DEFAULT_RULE_NAME ? 1..-1 : 2..-1])
        self.value = ValueExtractor.get(input, attribute)
        self.klass = self.initialize_rule(name, value, parameters)
      end

      def self.call(input, term_array)
        self.new(input, term_array)
      end

      private

      def normalize(parameters)
        parameters.map do |parameter|
          case parameter.downcase
          when 'true' then true
          when 'false' then false
          when /\A\d+\z/ then parameter.to_i
          when /\A\d+\.\d+\z/ then parameter.to_f
          else parameter
          end
        end
      end

      def initialize_rule(name, value, parameters)
        rule_class = Rules.const_get(name.camelize)
        rule_class.new(name, value, parameters)
      end
    end
  end
end
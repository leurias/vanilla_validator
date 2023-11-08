# frozen_string_literal: true

module VanillaValidator
  # RuleParser is responsible for parsing validation rules defined in a contract term.
  class RuleParser
    # Public: Parse a contract term to extract validation rules.
    #
    # term - The contract term to parse, which may include one or more validation rules separated by '|'.
    #
    # Returns: An array of Rule objects representing the parsed validation rules.
    #
    # Examples:
    #   RuleParser.parse('required|min:5') #=> [Rule.new('required', []), Rule.new('min_length', ['5'])]
    #
    def self.parse(term)
      if term.respond_to?(:call)
        [Rule.new('block_rule', term)]
      elsif term.respond_to?(:valid?)
        [Rule.new('custom_rule', term)]
      else
        parse_rules(term)
      end
    end

    private

    # Private: Parse individual validation rules from a contract term.
    #
    # term - The contract term to parse, which may include one or more validation rules separated by '|'.
    #
    # Returns: An array of Rule objects representing the parsed validation rules.
    #
    def self.parse_rules(term)
      rules = term.split('|')

      rules.map do |rule|
        rule_name, params = rule.split(':') if rule.respond_to?(:split)
        parameters = params.split(',') if params.respond_to?(:split)

        Rule.new(rule_name, parameters)
      end
    end
  end
end
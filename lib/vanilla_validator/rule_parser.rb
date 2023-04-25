# frozen_string_literal: true

module VanillaValidator
  class RuleParser

    def self.parse(protocol)
      arr = []

      if protocol.respond_to?(:call)
        arr << Rule.new('proc', protocol)
        return arr
      end

      if protocol.respond_to?(:passes)
        arr << Rule.new('custom', protocol)
        return arr
      end

      rules = protocol.split('|')
      
      rules.map do |rule|
        rule_name, params = rule.split(':') if rule.respond_to?(:split)
        parameters = params.split(',') if params.respond_to?(:split)

        arr << Rule.new(rule_name, parameters)
      end

      arr
    end

  end
end
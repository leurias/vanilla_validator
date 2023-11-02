# frozen_string_literal: true

require "i18n"
require 'uri'
require 'date'
require 'active_support/inflector'
require_relative "vanilla_validator/my_validation"
require_relative "vanilla_validator/version"
require_relative "vanilla_validator/value_extractor"
require_relative "vanilla_validator/rule"
require_relative "vanilla_validator/rule_parser"
require_relative "vanilla_validator/nested_rule"
require_relative "vanilla_validator/rules/base_rule"
require_relative "vanilla_validator/rules/after"
require_relative "vanilla_validator/rules/after_or_equal"
require_relative "vanilla_validator/rules/before"
require_relative "vanilla_validator/rules/boolean"
require_relative "vanilla_validator/rules/date"
require_relative "vanilla_validator/rules/email"
require_relative "vanilla_validator/rules/eq"
require_relative "vanilla_validator/rules/falsy"
require_relative "vanilla_validator/rules/gte"
require_relative "vanilla_validator/rules/in"
require_relative "vanilla_validator/rules/like"
require_relative "vanilla_validator/rules/max"
require_relative "vanilla_validator/rules/min"
require_relative "vanilla_validator/rules/numeric"
require_relative "vanilla_validator/rules/required"
require_relative "vanilla_validator/rules/required_if"
require_relative "vanilla_validator/rules/url"
# require "zeitwerk"

# loader = Zeitwerk::Loader.for_gem
# loader.setup


I18n.load_path += Dir[File.dirname(__FILE__) + "/locale/*.yml"]

module VanillaValidator
  @messages = {}
  @validated = nil

  def self.validate(input, contracts, options = {})
    @input = input
    @messages = {}
    @validated = init_clone

    contracts.each do |attribute, contract|
      value = ValueExtractor.get(input, attribute)
      rules = RuleParser.parse(contract)

      rule_results = rules.map do |rule|
        validator(attribute, value, rule)
      end

      invalid_rules = rule_results.reject(&:valid?)
      if invalid_rules.empty?
        data_set(@validated, attribute, value)
      else
        invalid_rules.each do |result|
          add_failure(attribute, result.failure_message)
        end
      end
    end

    @validated = delete_missing_values(@validated)

    OpenStruct.new(errors: errors, valid: valid?, validated: @validated)
  end

  def self.get_input
    @input
  end

  def self.errors
    @messages
  end

  def self.valid?
    @messages.empty?
  end

  def self.validator(attribute, value, rule)
    Rules.const_get(rule.name.camelize).new(attribute, value, rule.parameters)
  end

  def self.add_failure(attribute, message)
    @messages[attribute] ||= []
    @messages[attribute] << message
  end

  def self.init_clone
    new_input = @input.dup
    nullify_values(new_input)
  end

  def self.data_set(array, key, value)
    keys = key.split(".")
    last_key = keys.pop

    target = keys.reduce(array) do |hash, k|
      case k
      when "*"
        hash.last ||= {}
        hash.last
      else
        hash[k] ||= {}
        hash[k]
      end
    end

    if last_key == "*"
      target << value
    else
      target[last_key] = value
    end

    array
  end

  def self.delete_missing_values(hash)
    hash.each do |k, v|
      if v == '__missing__'
        hash.delete(k)
      elsif v.kind_of?(Array)
        hash[k] = v.reject { |item| item == '__missing__' }
      end
    end
    return hash
  end

  def self.nullify_values(hash)
    hash.each do |key, value|
      if value.is_a?(Hash)
        nullify_values(value)
      elsif value.is_a?(Array)
        value.each { |item| nullify_values(item) if item.is_a?(Hash) }
      else
        hash[key] = '__missing__'
      end
    end
  end
end

# loader.eager_load # We need all commands loaded.
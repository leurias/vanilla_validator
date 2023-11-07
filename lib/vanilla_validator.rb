# frozen_string_literal: true

require 'i18n'
require 'uri'
require 'date'
require 'active_support/inflector'
require "zeitwerk"

# Configure Zeitwerk to load the classes and modules.
loader = Zeitwerk::Loader.for_gem
loader.ignore("#{__dir__}/vanilla_validator/railtie.rb")
loader.setup
loader.eager_load

# Add custom locales for I18n.
I18n.load_path += Dir[File.dirname(__FILE__) + "/locale/*.yml"]

# VanillaValidator is a Ruby module that provides validation functionality.
module VanillaValidator
  extend self

  # Extend the module with the methods from the Helpers module.
  extend Helpers

  # Public: Validate input data against a contract.
  #
  # input - The input data to be validated.
  # contract - A set of validation rules defined as a Hash.
  # options - A Hash of additional options for validation (optional).
  #
  # NOTE: The `@raw_input` instance variable is used in nested rules to prevent excessive parameter passing.
  #
  # Returns a Result object containing the validated attributes and any errors.
  def validate(input, contract, options = {})
    @raw_input = input.dup

    errors = {}
    validated = deep_clone_input(input)

    contract.each do |attribute, term|
      value  = ValueExtractor.get(input, attribute)
      rules  = RuleParser.parse(term)

      initialized_rules = rules.map do |rule|
        initialize_rule(attribute, value, rule)
      end

      invalid_rules = initialized_rules.reject(&:valid?)

      if invalid_rules.empty?
        data_set(validated, attribute, value)
      else
        invalid_rules.each do |result|
          (errors[attribute] ||= []) << result.failure_message
        end
      end
    end

    # Remove any missing or invalid attributes from the validated data.
    validated_attributes = delete_missing_values(validated)

    Result.new(validated_attributes, errors)
  end

  # Public: Validate input data against a contract, stopping on the first failure.
  #
  # input    - The input data to validate.
  # contract - A contract specifying validation rules for input data.
  #
  # Returns: A Result object containing validated data and error messages.
  #
  def validate!(input, contract)
    validate(input, contract, stop_on_first_failure: true)
  end

  def raw_input
    @raw_input
  end

  private

  # Private: Initialize a validation rule based on its name and parameters.
  #
  # attribute - The attribute being validated.
  # value     - The value to validate.
  # rule      - A rule object containing the name and parameters of the rule.
  #
  # Returns: An instance of the specific validation rule.
  #
  def initialize_rule(attribute, value, rule)
    rule_class = Rules.const_get(rule.name.camelize)
    rule_class.new(attribute, value, rule.parameters)
  end
end

require 'vanilla_validator/railtie' if defined? Rails
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

I18n.load_path += Dir[File.dirname(__FILE__) + "/locale/*.yml"]

module VanillaValidator

  def self.validate(input, contracts, options = {})
    VanillaValidator::Validator.new(input, contracts, options).call
  end

end
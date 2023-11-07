# frozen_string_literal: true

# The VanillaValidator::Railtie class is responsible for integrating validation
# methods into ActionController::Parameters in a Ruby on Rails application.

require 'rails/railtie'

module VanillaValidator
  class Railtie < ::Rails::Railtie
    # Initializes and configures the integration of validation methods.
    initializer 'vanilla_validator' do
      ActiveSupport.on_load :action_controller do
        # Include the ValidationExtensions module within ActionController::Parameters.
        ActionController::Parameters.include(ValidationExtensions)
      end
    end
  end

  # The ValidationExtensions module provides methods for validating
  # ActionController::Parameters against a specified contract.
  module ValidationExtensions
    # Validates the ActionController::Parameters against the specified contract.
    #
    # @param contract [Hash] A contract specifying validation rules.
    #
    # @return [Object] The result of the validation.
    def validate(contract)
      VanillaValidator.validate(self.to_unsafe_h, contract)
    end

    # Validates the ActionController::Parameters against the specified contract
    # and raises an exception if the validation fails.
    #
    # @param contract [Hash] A contract specifying validation rules.
    def validate!(contract)
      VanillaValidator.validate!(self.to_unsafe_h, contract)
    end
  end
end

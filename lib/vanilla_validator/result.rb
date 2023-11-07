module VanillaValidator
  # Result represents the outcome of a validation operation, including validated data and errors.
  class Result
    attr_accessor :validated, :errors

    def initialize(validated, errors = {})
      @validated = validated
      @errors = errors
    end

    def valid?
      errors.empty?
    end
  end
end

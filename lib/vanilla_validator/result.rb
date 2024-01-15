module VanillaValidator
  # Result represents the outcome of a validation operation, including validated data and errors.
  class Result
    attr_accessor :validated, :errors

    def initialize(validated, errors = {})
      @validated = validated.with_indifferent_access
      @errors = errors.with_indifferent_access
    end

    def success?
      errors.empty?
    end

    def failed?
      errors.any?
    end

    alias :valid? :success?
  end
end

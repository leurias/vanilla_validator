# frozen_string_literal: true

module VanillaValidator
  class ValueExtractor
    # Public: Extracts data from a nested structure using a path.
    #
    # data - The nested data structure (Hash or Array) to extract data from.
    # path - A string representing the path to the desired data, where
    #        individual segments are separated by periods ('.').
    #
    # Raises:
    # - RuntimeError: If the path contains more than 5 segments, which
    #   exceeds the maximum allowed.
    #
    # Returns: The extracted data, or nil if the path does not lead to a valid value.
    #
    def self.get(data, path)
      path_components = path.split('.')

      raise "Too many path segments (maximum allowed is 5)" if path_components.length > 5

      if path.include?("*")
        self.get_at_wildcard_path(data, path_components)
      else
        self.get_at_explicit_path(data, path_components)
      end
    end

    private

    # Private: Extracts data from a nested structure using an explicit path.
    #
    # data - The nested data structure (Hash or Array) to extract data from.
    # path - An array of path segments.
    #
    # Returns: The extracted data, or nil if the path does not lead to a valid value.
    #
    def self.get_at_explicit_path(data, path)
      data.dig(*steps_from(path))
    end

    # Private: Converts an array of path segments into appropriate data access steps.
    #
    # path - An array of path segments.
    #
    # Returns: An array of steps for data access (string keys or integer indices).
    #
    def self.steps_from path
      path.map do |step|
        step.match?(/\D/) ? step.to_s : step.to_i
      end
    end

    # Private: Extracts data from a nested structure using a path that includes wildcard segments ('*').
    #
    # data - The nested data structure (Array) to extract data from.
    # path - An array of path segments with wildcard(s).
    # default - The value to return if the path does not lead to a valid value.
    #
    # Returns: The extracted data or the default value if the path does not lead to a valid value.
    #
    def self.get_at_wildcard_path(data, path, default = nil)
      return data if path.empty?

      path.each_with_index do |segment, index|
        return data if segment.nil?

        if segment == "*"
          remaining_path = path[index.next..-1] || []

          return default unless data.is_a?(Array)

          result = data.map { |item| get_at_wildcard_path(item, remaining_path) }

          return remaining_path.include?("*") ? result.flatten : result
        end

        if data.is_a?(Hash) && data.key?(segment)
          data = data[segment]
        elsif data.is_a?(Array) && ( Integer(segment) rescue false )
          data = data[Integer(segment)]
        else
          return default
        end

      end

      return data
    end
  end
end
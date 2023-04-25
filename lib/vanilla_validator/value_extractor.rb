# frozen_string_literal: true

module VanillaValidator
  class ValueExtractor

    def self.get(data, path)
      if path.include?("*")
        self.get_at_wildcard_path(data, path)
      else
        self.get_at_explicit_path(data, path)
      end
    end

    private
      def self.get_at_explicit_path(data, path)
        data.dig(*steps_from(path))
      end

      def self.steps_from path
        path.split('.').map do |step|
          if step.match?(/\D/)
            step.to_s
          else
            step.to_i
          end
        end
      end

      def self.get_at_wildcard_path(data, path, default = nil)
        path = path.is_a?(Array) ? path : path.split(".")

        if path.empty?
          return data
        end

        path.each_with_index do |segment, index|
          if segment.nil?
            return data
          end

          if segment.eql?("*")
            rpath = path[index.next..-1] || []

            unless data.is_a?(Array)
              return default
            end

            result = []

            data.each do |item|
              result << self.get_at_wildcard_path(item, rpath)
            end

            return rpath.include?("*") ? result.flatten : result
          end

          if data.is_a?(Hash) && data.key?(segment)
            data = data[segment]
          elsif target.is_a?(Array) && ( Integer(segment) rescue false )
            target = target[Integer(segment)]
          else
            return default
          end

        end

        return data
      end

  end
end
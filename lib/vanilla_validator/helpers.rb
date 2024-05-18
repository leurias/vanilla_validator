module VanillaValidator
  # Helpers module contains various utility methods used by the VanillaValidator module.
  module Helpers
    private

    # Private: Deep clone the input data while nullifying certain values.
    #
    # data - The input data to clone.
    #
    # Returns: A deep clone of the input data with specific values nullified.
    #
    def deep_clone_input(data)
      new_input = Marshal.load(Marshal.dump(data))
      nullify_values(new_input)
      new_input
    end

    # Private: Recursively nullify values in a hash.
    #
    # hash - The hash in which values are to be nullified.
    #
    # Returns: The hash with specific values replaced by '__missing__'.
    #
    def nullify_values(hash)
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

    # Private: Set data within a nested structure based on a provided key.
    #
    # array - The nested data structure to modify.
    # key   - The key specifying the location to set the value.
    # value - The value to set.
    #
    # Returns: The modified nested data structure.
    #
    def data_set(array, key, value)
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

    # Private: Remove entries with '__missing__' values from a hash.
    #
    # hash - The hash from which entries with '__missing__' values are to be removed.
    #
    # Returns: The hash with '__missing__' values removed.
    #
    def delete_missing_values(hash)
      hash.each do |k, v|
        if v == '__missing__'
          hash.delete(k)
        elsif v.kind_of?(Array)
          hash[k] = v.reject { |item| item == '__missing__' }
        elsif v.kind_of?(Hash)
          hash[k] = delete_missing_values(v)
        end
      end
      hash
		end
  end
end
module Utils
  module Converters
    # Converts a string into an integer
    class StringToInt
      def convert(string:)
        string.to_i
      end
    end
  end
end

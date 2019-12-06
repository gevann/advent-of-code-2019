module Utils
  module Converters
    # Converts a string into an integer
    class StringToStringArray
      def convert(string:)
        string.split(',').map(&:strip)
      end
    end
  end
end

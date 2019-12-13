module Utils
  module Converters
    # Converts a string into an integer
    class StringToSymbolArray
      def convert(string:)
        string.split(')').map { |str| str.strip.to_sym }
      end
    end
  end
end

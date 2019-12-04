require 'forwardable'
require 'utils/converters/string_to_int'

module Utils
  module Io
    # Streams lines from a file through a converter.
    class StreamInput
      extend Forwardable
      def_delegator(:@file_handle, :to_sym)

      def initialize(file_handle:, converter: Converters::StringToInt.new)
        raise ArgumentError, 'File not found' unless File.exist?(file_handle)

        @file_handle = file_handle
        @converter = converter
      end

      def each
        return enum_for :each unless block_given?

        File.open(file_handle) do |f|
          while (line = f.gets)
            yield converter.convert(string: line)
          end
        end
      end

      private

      attr_reader :file_handle, :converter
    end
  end
end

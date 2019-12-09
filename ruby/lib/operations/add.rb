require 'operations/binary_operation'

module Operations
  class Add < BinaryOperation
    def self.call(tape, instruction, _output_stream)
      BinaryOperation.(tape, instruction)
    end

    def self.evaluate(a, b)
      a + b
    end
  end
end

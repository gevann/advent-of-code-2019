require '02/operations/binary_operation'

module Operations
  class Multiply < BinaryOperation
    def self.call(tape)
      BinaryOperation.(tape, self)
    end

    def self.evaluate(a, b)
      a * b
    end
  end
end

require '02/operations/binary_operation'

module Operations
  class Multiply < BinaryOperation
    def self.call(tape)
      BinaryOperation.(tape, lambda { |a, b| a * b })
    end
  end
end

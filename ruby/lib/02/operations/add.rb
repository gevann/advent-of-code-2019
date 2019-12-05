require '02/operations/binary_operation'

module Operations
  class Add < BinaryOperation
    def self.call(tape)
      BinaryOperation.(tape, lambda { |a, b| a + b })
    end
  end
end

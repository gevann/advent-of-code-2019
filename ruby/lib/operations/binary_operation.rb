module Operations
  class BinaryOperation
    N_VALUES = 4
    def self.call(tape, instruction)
      _opcode, location_a, location_b, location_c = tape.scan(N_VALUES)
      position = tape.position

      operand_a = instruction.operands.next.(tape, location_a)
      operand_b = instruction.operands.next.(tape, location_b)

      result = instruction.operator.evaluate(operand_a, operand_b)

      tape.write(result, location_c)
      tape.move_to(position + 1)
      tape
    end
  end
end

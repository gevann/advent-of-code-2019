module Operations
  module JumpIf
    N_VALUES = 3
    def self.call(tape, instruction, expression)
      _opcode, location_a, location_b = tape.scan(N_VALUES)
      position = tape.position

      value_a = instruction.operands.next.(tape, location_a)
      value_b = instruction.operands.next.(tape, location_b)

      if instruction.operator.evaluate(value_a)
        tape.move_to(value_b)
      else
        tape.move_to(position + 1)
      end

      tape
    end
  end
end

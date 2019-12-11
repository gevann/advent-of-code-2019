module Operations
  module Comparison
    N_VALUES = 4
    def self.call(tape, instruction, expression)
      _opcode, location_a, location_b, location_c = tape.scan(N_VALUES)
      position = tape.position

      value_a = instruction.operands.next.(tape, location_a)
      value_b = instruction.operands.next.(tape, location_b)
      value_c = instruction.operands.next.(tape, location_c)

      tape.write(
        instruction.operator.evaluate(value_a, value_b),
        value_c
      )

      tape.move_to(position + 1)
      tape
    end
  end
end

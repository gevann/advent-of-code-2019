module Operations
  N_VALUES = 4
  class BinaryOperation
    def self.call(tape, binary_fn)
      _opcode, location_a, location_b, location_c = tape.scan(N_VALUES)
      position = tape.position

      tape.move_to(location_a)
      operand_a = tape.value

      tape.move_to(location_b)
      operand_b = tape.value

      result = binary_fn.(operand_a, operand_b)

      tape.write(result, location_c)
      tape.move_to(position + 1)
      tape
    end
  end
end

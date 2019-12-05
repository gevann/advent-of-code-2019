class Operation
  def self.call(tape, binary_fn)
    _opcode, location_a, location_b, location_c = tape.scan(4)
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

  def self.+(tape)
    call(tape, lambda { |a, b| a + b })
  end

  def self.*(tape)
    call(tape, lambda { |a, b| a * b })
  end
end

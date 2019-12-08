module Operations
  N_VALUES = 2
  class Input
    def self.call(tape)
      _opcode, location = tape.scan(N_VALUES)
      position = tape.position

      input = gets&.to_i

      tape.write(input, location)
      tape.move_to(position + 1)
      tape
    end
  end
end

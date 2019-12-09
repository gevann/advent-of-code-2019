module Operations
  class Output
    N_VALUES = 2
    def self.call(tape, instruction, output_stream = $stdout)
      _opcode, location = tape.scan(N_VALUES)
      position = tape.position

      value = instruction.operands.next.(tape, location)
      output_stream.print("#{value}\n")

      tape.move_to(position + 1)
      tape
    end
  end
end

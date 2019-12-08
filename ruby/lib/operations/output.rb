module Operations
  class Output
    N_VALUES = 2
    def self.call(tape, _instruction, output_stream: $stdout)
      _opcode, location = tape.scan(N_VALUES)
      position = tape.position

      value = tape.move_to(location)
      output_stream.print("#{value}\n")

      tape.move_to(position + 1)
      tape
    end
  end
end

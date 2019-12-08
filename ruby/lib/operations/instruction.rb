require 'yaml'

require 'operations'

module Operations
  class Instruction
    attr_reader :opcode, :operator

    EXIT = 'Exit'.freeze

    INPUT_MODES  = {
      0 => lambda { |tape, location| tape.move_to(location) },
      1 => lambda { |_tape, value| value }
    }

    def initialize(tape_value, opcode_lang = 'spec/fixtures/02/opcode_lang.yml')
      a, b, c, d, e = ('%05i' % tape_value).split('').map(&:to_i)

      @opcode_map = ::YAML.load_file(opcode_lang)
      @opcode = (d*10) + e
      @input_modes = {
        1 => INPUT_MODES.fetch(c),
        2 => INPUT_MODES.fetch(b),
        3 => INPUT_MODES.fetch(a),
      }
      @operator = Operations.const_get(@opcode_map.fetch(@opcode, EXIT))
    end

    def operands
      @input_modes.values.to_enum
    end
  end
end

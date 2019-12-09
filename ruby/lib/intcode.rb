require 'yaml'

require 'utils/memoized_results'

require 'operations'
require 'tape'

class Intcode
  include MemoizedResults
  TapeNotLoadedError = Class.new(StandardError)

  EXIT = 'Exit'.freeze

  attr_reader :output

  def initialize(opcode_lang = 'spec/fixtures/02/opcode_lang.yml', output = $stdout)
    @opcode_map = ::YAML.load_file(opcode_lang)
    @output = output
  end

  def outputs
    @output.to_a
  end

  def load(stream)
    @tape = Tape.new(stream.each.to_a)
  end

  def set_memory(value, address)
    raise TapeNotLoadedError unless @tape

    @tape.write(value, address)
    @tape.move_to(0)
    @tape
  end

  def call
    raise TapeNotLoadedError unless @tape

    memoized_results(@tape, __callee__) do
      run(@tape)
    end
  end

  def self.detect(range, num_vars, target, stream)
    range.
      to_a.
      repeated_permutation(num_vars).
      detect do |(a, b)|
        instance = new
        instance.load(stream)
        instance.set_memory(a, 1)
        instance.set_memory(b, 2)
        instance.call.move_to(0) == target
      end
  end

  private

  def run(tape)
    instruction = Operations::Instruction.new(tape.value, @opcode_map, @output)
    run(instruction.execute(tape))
  rescue SystemExit
    tape
  end
end

require 'yaml'

require 'utils/memoized_results'

require '02/operations'
require '02/tape'

class Intcode
  include MemoizedResults
  TapeNotLoadedError = Class.new(StandardError)

  EXIT = 'Exit'.freeze

  def initialize(opcode_lang = 'spec/fixtures/02/opcode_lang.yml')
    @opcode_map = ::YAML.load_file(opcode_lang)
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

  private

  def run(tape)
    operation = Operations.const_get(@opcode_map.fetch(tape.value, EXIT))
    run(operation.(tape))
  rescue SystemExit
    tape
  end
end

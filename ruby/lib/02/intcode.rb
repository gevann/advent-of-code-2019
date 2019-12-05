require 'yaml'

require 'utils/memoized_results'

require '02/operations'
require '02/tape'

class Intcode
  include MemoizedResults
  EXIT = 'Exit'.freeze

  def initialize(opcode_lang = 'spec/fixtures/02/opcode_lang.yml')
    @opcode_map = ::YAML.load_file(opcode_lang)
  end

  def call(stream)
    memoized_results(stream, __callee__) do
      tape = Tape.new(stream.each.to_a)

      run(tape)
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

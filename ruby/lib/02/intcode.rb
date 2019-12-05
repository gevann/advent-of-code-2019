require 'utils/memoized_results'

require '02/operation'
require '02/tape'

class Intcode
  include MemoizedResults
  EXIT = 99

  def initialize(opcode_map: { 1 => :+, 2 => :*, 99 => EXIT })
    @opcode_map = opcode_map
  end

  def call(stream)
    memoized_results(stream, __callee__) do
      tape = Tape.new(stream.each.to_a)

      run(tape)
    end
  end

  private

  def run(tape)
    opt = @opcode_map.fetch(tape.value, EXIT)
    if opt == EXIT
      tape
    else
      run(Operation.public_send(opt, tape))
    end
  end
end

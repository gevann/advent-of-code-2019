require 'operations/jump_if'

module Operations
  class JumpIfFalse
    def self.call(tape, instruction, expression)
      JumpIf.call(tape, instruction, expression)
    end

    def self.evaluate(value)
      value.zero?
    end
  end
end

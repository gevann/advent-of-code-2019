module Operations
  class JumpIfTrue
    def self.call(tape, instruction, expression)
      JumpIf.call(tape, instruction, expression)
    end

    def self.evaluate(value)
      !value.zero?
    end
  end
end

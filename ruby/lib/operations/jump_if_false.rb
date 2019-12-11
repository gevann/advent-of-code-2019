require 'operations/jump_if'

module Operations
  class JumpIfFalse
    def self.evaluate(value)
      value.zero?
    end
  end
end

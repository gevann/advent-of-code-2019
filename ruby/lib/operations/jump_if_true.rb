module Operations
  class JumpIfTrue
    def self.evaluate(value)
      !value.zero?
    end
  end
end

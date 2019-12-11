module Operations
  module LessThan
    def self.call(tape, instruction, expression)
      Comparison.call(tape, instruction, expression)
    end

    def self.evaluate(x, y)
      if x < y
        Operations::TRUE
      else
        Operations::FALSE
      end
    end
  end
end

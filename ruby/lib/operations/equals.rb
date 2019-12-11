module Operations
  module Equals
    def self.evaluate(x, y)
      if x == y
        Operations::TRUE
      else
        Operations::FALSE
      end
    end
  end
end

require 'utils/memoized_results'

class RecursiveEquation
  include MemoizedResults

  def call(amount, acc = [])
    memoized_results(amount.to_s, __callee__) do
      helper((amount/3) - 2, []).sum
    end
  end

  private

  def helper(mass, acc)
    next_mass = (mass/3) - 2

    if next_mass.negative?
      acc.push(mass)
    else
      helper(next_mass, acc.push(mass))
    end
  end
end

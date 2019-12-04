require 'utils/memoized_results'

# Counter-uppers the fuel.
class Fuel
  include MemoizedResults
  # @param stream [#each] a stream of input data.
  def initialize(fuel_equation: lambda { |mass| (mass / 3) - 2} )
    @fuel_equation = fuel_equation
  end

  def counter_upper(stream)
    memoized_results(stream, __callee__) do
      stream.each.inject(0) { |acc, mass| acc + fuel_equation.(mass) }
    end
  end

  private

  attr_reader :fuel_equation
end

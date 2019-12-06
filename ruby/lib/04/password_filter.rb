class PasswordFilter
  PASSWORD_LENGTH = 6

  def initialize(range)
    @range = range
  end

  def call
    range.select { |number| meets_criteria?(number) }
  end

  private

  attr_reader :range

  def meets_criteria?(number)
    digits = number.digits

    Math.log10(number).to_i + 1 == PASSWORD_LENGTH &&
      monotonic_decrease?(digits) &&
      repeated_digit?(digits)
  end

  def monotonic_decrease?(digits)
    !!digits.inject do |prev, curr|
      return false unless curr <= prev
      curr
    end
  end

  def repeated_digit?(digits)
    map = digits.group_by { |e| digits.count(e) }
    map.fetch(2, false)
  end
end

require_relative '../spec_helper'

require '01/recursive_equation'

RSpec.describe RecursiveEquation do
  let(:instance) { described_class.new }

  describe '#call' do
    subject { instance.call(amount) }
    let(:amount) { 100756 }

    it 'recursively sums the amount' do
      expect(subject).to eq(50346)
    end
  end
end

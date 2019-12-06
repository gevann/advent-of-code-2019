require_relative '../../spec_helper'

require '03/distance/manhattan'
require '03/point'

RSpec.describe Distance::Manhattan do
  describe '.calculate' do
    subject { described_class.calculate(p1, p2) }
    let(:p1) { Point.new(0, 0) }
    let(:p2) { Point.new(3, 3) }

    it { is_expected.to eq(6) }
  end
end

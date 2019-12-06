require_relative '../../spec_helper'

require '03/distance/steps'
require '03/point'

RSpec.describe Distance::Steps do
  describe '.calculate' do
    subject { described_class.calculate(p1, p2) }
    let(:p1) { Point.new(0, 0, path_position: 7) }
    let(:p2) { Point.new(3, 3, path_position: 3) }

    it { is_expected.to eq(10) }
  end
end

require_relative '../../spec_helper'

require '03/distance/steps'
require '03/point'

RSpec.describe Distance::Steps do
  describe '.calculate' do
    subject { described_class.calculate(path_positions) }
    let(:path_positions) do
      { foo: 11, bar: 12 }
    end

    it { is_expected.to eq(23) }
  end
end

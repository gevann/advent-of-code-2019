require_relative '../spec_helper'

require '03/point'

RSpec.describe Point do
  describe '.translate' do
    subject { instance.translate(motion) }

    let(:instance) { Point.new(0, 0) }
    let(:motion)   { 'R5' }

    it { is_expected.to eq(Point.new(5, 0))}

    context 'when moving down' do
      let(:motion) { 'D1' }
      it { is_expected.to eq(Point.new(0, -1))}
    end
  end

  describe '.points_in_translation' do
    let(:instance) { Point.new(0, 0) }
    let(:motion)   { 'R5' }
    subject { instance.points_in_translation(motion) }

    it 'returns collection of all intermediate points' do
      expect(subject).to eq([
        Point.new(1,0),
        Point.new(2,0),
        Point.new(3,0),
        Point.new(4,0),
        Point.new(5,0),
      ])
    end
  end
end

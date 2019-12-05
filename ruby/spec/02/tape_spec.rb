require_relative '../spec_helper'

require '02/tape'

RSpec.describe Tape do
  let(:instance) { described_class.new(arr) }
  let(:arr) { [10, 9, 8, 7, 6, 4, 3, 2, 1, 0] }

  describe '#move_to' do
    subject { instance.move_to(location) }

    let(:location) { 5 }

    it 'updates the position' do
      expect { subject }.to change { instance.position }.from(0).to(5)
    end

    it 'returns the value at the new position' do
      expect(subject).to eq(4)
    end

    context 'with a location outside the tape' do
      let(:location) { 100 }

      it 'raises an argument error' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#value' do
    subject { instance.value }

    it 'returns the value at the current position' do
      expect(subject).to eq(10)
    end
  end

  describe '#scan' do
    subject { instance.scan(count) }
    let(:count) { 3 }
    before { instance.move_to(3) }

    it { is_expected.to eq([7, 6, 4]) }

    it 'updates the position' do
      expect { subject }.to change { instance.position }.from(3).to(5)
    end
  end

  describe '#write' do
    subject { instance.write(5, 5) }

    it 'overwrites the location with the new value' do
      expect { subject }.to change { arr[5] }.from(4).to(5)
    end

    it 'updates the position' do
      expect { subject }.to change { instance.position }.from(0).to(5)
    end
  end
end

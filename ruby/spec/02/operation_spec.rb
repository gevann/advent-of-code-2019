require_relative '../spec_helper'

require '02/operation'
require '02/tape'

RSpec.describe Operation do
  let(:tape) { Tape.new(arr) }
  let(:arr)  { [1, 0, 0, 0, 99] }

  describe '.+' do
    subject { Operation.+(tape) }

    it 'adds the values and writes the in the location' do
      expect { subject }.to change { arr }.from([1, 0, 0, 0, 99]).to([2, 0, 0, 0, 99])
    end

    it 'advances the tape beyond all used inputs' do
      expect { subject }.to change { tape.position }.from(0).to(4)
    end

    it 'returns the tape' do
      expect(subject).to be_a(Tape)
    end
  end

  describe '.*' do
    let(:arr)  { [2, 3, 0, 3, 99] }
    subject { Operation.*(tape) }
    it 'adds the values and writes the in the location' do
      expect { subject }.to change { arr }.from([2, 3, 0, 3, 99]).to([2, 3, 0, 6, 99])
    end

    it 'advances the tape beyond all used inputs' do
      expect { subject }.to change { tape.position }.from(0).to(4)
    end

    it 'returns the tape' do
      expect(subject).to be_a(Tape)
    end
  end
end

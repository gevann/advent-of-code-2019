require_relative '../../spec_helper'

require '05/operations/instruction'

RSpec.describe Operations::Instruction do
  let(:instance)   { described_class.new(tape_value) }
  let(:tape_value) { 1002 }

  describe '.new' do
    subject { instance }

    it { is_expected.to be_a(Operations::Instruction) }

    it 'finds the correct operation' do
      expect(subject.operator).to eq(Operations::Multiply)
    end

    context 'when the op code is not recognized' do
      let(:tape_value) { 1007 }

      it 'defaults to the Exit operation' do
        expect(subject.operator).to eq(Operations::Exit)
      end
    end
  end
end

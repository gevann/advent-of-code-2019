require_relative '../../spec_helper'

require 'operations/instruction'
require 'tape'

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

  describe '#operands' do
    subject { instance.operands }
    let(:tape)   { Tape.new([1, 2, 3, 4]) }
    let(:number) { 0 }

    it { is_expected.to be_a Enumerator }

    it 'returns lambdas for fetching the value correctly' do
      expect(subject.next.(tape, 3)).to eq(4)
      expect(subject.next.(tape, 9)).to eq(9)
    end
  end
end

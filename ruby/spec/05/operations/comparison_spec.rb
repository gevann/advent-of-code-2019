require_relative '../../spec_helper'

require 'operations'
require 'tape'

RSpec.describe Operations::Comparison do
  let(:instruction) { Operations::Instruction.new(value, opcode_map)}
  let(:tape)        { Tape.new(arr) }
  let(:value)       { tape.value }
  let(:less_than)   { 7 }
  let(:equals)      { 8 }

  let(:opcode_map) do
    {less_than => 'LessThan', equals => 'Equals' }
  end

  describe '.call' do
    subject    { described_class.call(tape, instruction, nil) }
    let(:arr)  { [7, 1, 1, 1, 1] }

    it 'returns the tape' do
      expect(subject).to be_a(Tape)
    end

    it 'advances the tape past all used parameters' do
      expect { subject }.to change { tape.position }.from(0).to(4)
    end

    context 'when the instruction is LessThan' do
      let(:arr)  { [less_than, 3, 4, 4, 5, 99] }

      context 'and the expression evals to true' do
        it 'writes a 1 at the correct location' do
          expect { subject }.to change { arr[5] }.from(99).to(1)
        end
      end

      context 'and the expression evals to false' do
        let(:arr)  { [less_than, 4, 4, 4, 5, 99] }

        it 'writes a 1 at the correct location' do
          expect { subject }.to change { arr[5] }.from(99).to(0)
        end
      end
    end

    context 'when the instruction is Equals' do
      let(:arr)  { [equals, 4, 4, 4, 5, 99] }

      context 'and the expression evals to true' do
        it 'writes a 1 at the correct location' do
          expect { subject }.to change { arr[5] }.from(99).to(1)
        end
      end

      context 'and the expression evals to false' do
        let(:arr)  { [equals, 3, 4, 4, 5, 99] }

        it 'writes a 1 at the correct location' do
          expect { subject }.to change { arr[5] }.from(99).to(0)
        end
      end
    end
  end
end

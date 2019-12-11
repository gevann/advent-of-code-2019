require_relative '../../spec_helper'

require 'operations'
require 'tape'

RSpec.describe Operations::JumpIf do
  let(:instruction)   { Operations::Instruction.new(value, opcode_map)}
  let(:tape)          { Tape.new(arr) }
  let(:value)         { tape.value }
  let(:jump_if_true)  { 5 }
  let(:jump_if_false) { 6 }

  let(:opcode_map) do
    {jump_if_true => 'JumpIfTrue', jump_if_false => 'JumpIfFalse' }
  end

  describe '.call' do
    subject    { described_class.call(tape, instruction, nil) }
    let(:arr)  { [5, 1, 1, 1, 1] }

    it 'returns the tape' do
      expect(subject).to be_a(Tape)
    end

    context 'when the instruction is JumpIfTrue' do
      let(:arr)  { [jump_if_true, 4, 3, 2, 1] }

      context 'and the expression evals to true' do
        it 'advances the tape to the jump location' do
          expect { subject }.to change { tape.position }.from(0).to(2)
        end
      end

      context 'and the expression evals to false' do
        let(:arr)  { [jump_if_true, 4, 3, 2, 0] }

        it 'advances the tape past all used parameters' do
          expect { subject }.to change { tape.position }.from(0).to(3)
        end
      end
    end

    context 'when the instruction is JumpIfFalse' do
      let(:arr)  { [jump_if_false, 4, 3, 2, 0] }

      context 'and the expression evals to true' do
        it 'advances the tape to the jump location' do
          expect { subject }.to change { tape.position }.from(0).to(2)
        end
      end

      context 'and the expression evals to false' do
        let(:arr)  { [jump_if_false, 4, 3, 2, 1] }

        it 'advances the tape past all used parameters' do
          expect { subject }.to change { tape.position }.from(0).to(3)
        end
      end
    end
  end
end

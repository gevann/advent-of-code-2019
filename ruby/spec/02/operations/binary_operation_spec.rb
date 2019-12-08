require_relative '../../spec_helper'

require 'operations/add'
require 'operations/binary_operation'
require 'operations/instruction'
require 'tape'

RSpec.describe Operations::BinaryOperation do
  let(:tape)        { Tape.new(arr) }
  let(:arr)         { [1, 0, 0, 0, 99] }
  let(:instruction) { Operations::Instruction.new(value, opcode_map)}
  let(:value)       { tape.value }
  let(:opcode_map)  { {1 => 'Add', 2 => 'Multiply' } }

  describe '.call' do
    subject { Operations::BinaryOperation.call(tape, instruction) }

    it 'runs the function on the values and writes the result in the location' do
      expect { subject }.
        to change { arr }.
        from([1, 0, 0, 0, 99]).
        to([2, 0, 0, 0, 99])
    end

    context 'with a mix of input modes' do
      let(:arr) { [1002, 4, 3, 4, 33] }

      it 'fetches values with the correct input modes' do
        expect { subject }.
          to change { arr }.
          from([1002, 4, 3, 4, 33]).
          to([1002, 4, 3, 4, 99])
      end
    end

    it 'advances the tape beyond all used inputs' do
      expect { subject }.to change { tape.position }.from(0).to(4)
    end

    it 'returns the tape' do
      expect(subject).to be_a(Tape)
    end
  end
end

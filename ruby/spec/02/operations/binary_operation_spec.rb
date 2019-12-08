require_relative '../../spec_helper'

require 'operations/binary_operation'
require 'operations/add'
require 'tape'

RSpec.describe Operations::BinaryOperation do
  let(:tape)      { Tape.new(arr) }
  let(:arr)       { [1, 0, 0, 0, 99] }
  let(:binary_op) { Operations::Add }

  describe '.call' do
    subject { Operations::BinaryOperation.call(tape, binary_op) }

    it 'runs the function on the values and writes the result in the location' do
      expect { subject }.to change { arr }.from([1, 0, 0, 0, 99]).to([2, 0, 0, 0, 99])
    end

    it 'advances the tape beyond all used inputs' do
      expect { subject }.to change { tape.position }.from(0).to(4)
    end

    it 'returns the tape' do
      expect(subject).to be_a(Tape)
    end
  end
end

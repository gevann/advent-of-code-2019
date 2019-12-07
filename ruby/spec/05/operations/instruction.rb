require_relative '../../spec_helper'

require '05/operations/instruction'

RSpec.describe Operations::Instruction do
  let(:instance)   { described_class.new(tape_value) }
  let(:tape_value) { 1002 }

  describe '.new' do
    subject { instance }

    it { is_expected.to be_a(Operations::Instruction) }

    it 'assigned the correct attributes' do
      expect(subject).to have_attributes(
        opcode: 2,
        input_modes: {
          1 => 0, 2 => 1, 3 => 0
        }
      )
    end
  end
end

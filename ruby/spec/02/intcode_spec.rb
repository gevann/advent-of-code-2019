require_relative '../spec_helper'

require 'intcode'

RSpec.describe Intcode do
  let(:stream)   { Utils::Io::StreamInput.new(file_handle: file, sep: ',') }
  let(:file)     { 'spec/fixtures/02/input_1.csv' }
  let(:instance) { described_class.new }

  describe '#load' do
    subject { instance.load(stream) }

    it 'loads the tape' do
      expect(subject).to be_a(Tape)
    end
  end

  describe '#set_memory' do
    let(:loaded_instance) do
      instance.load(stream)
      instance
    end

    subject { loaded_instance.set_memory(99, 0) }

    it 'updates the memory at the address in the tape without moving the position' do
      expect(subject.tape).to eq([99,9,10,3,2,3,11,0,99,30,40,50])
      expect(subject.position).to eq(0)
    end
  end

  describe '#call' do
    subject { loaded_instance.call }

    let(:loaded_instance) do
      instance.load(stream)
      instance
    end

    it 'returns the updated tape' do
      expect(subject).to be_a Tape
      expect(subject.tape).to eq([3500,9,10,70,2,3,11,0,99,30,40,50])
    end

    context 'with a 1202 program alarm input' do
      let(:file) { 'spec/fixtures/02/problem_1.csv' }

      let(:loaded_instance) do
        instance.load(stream)
        instance.set_memory(12, 1)
        instance.set_memory(2, 2)
        instance
      end

      it 'runs to completion' do
        expect(subject.move_to(0)).to eq(3101878)
      end
    end
  end

  describe '.detect' do
    subject { Intcode.detect(range, num_vars, target, stream) }
    let(:range)    { (0..99) }
    let(:num_vars) { 2 }
    let(:target)   { 19690720 }
    let(:file) { 'spec/fixtures/02/problem_1.csv' }

    it { is_expected.to eq([84, 44]) }
  end
end

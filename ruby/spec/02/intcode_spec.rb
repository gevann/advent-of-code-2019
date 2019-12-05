require_relative '../spec_helper'

require '02/intcode'

RSpec.describe Intcode do
  let(:stream)   { Utils::Io::StreamInput.new(file_handle: file, sep: ',') }
  let(:file)     { 'spec/fixtures/02/input_1.csv' }
  let(:instance) { described_class.new }

  describe '#call' do
    subject { instance.call(stream) }

    it 'returns the updated tape' do
      expect(subject).to be_a Tape
      expect(subject.tape).to eq([3500,9,10,70,2,3,11,0,99,30,40,50])
    end

    context 'with a 1202 program alarm input' do
      let(:file) { 'spec/fixtures/02/problem_1.csv' }

      it 'runs to completion' do
        expect(subject.move_to(0)).to eq(3101878)
      end
    end
  end
end

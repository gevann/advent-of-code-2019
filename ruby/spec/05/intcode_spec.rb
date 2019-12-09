require_relative '../spec_helper'

require 'operations'
require 'intcode'

RSpec.describe Intcode do

  class OutputArray
    def initialize
      @arr = []
    end

    def print(x)
      @arr.push(x.strip.to_i)
    end

    def to_a
      @arr
    end
  end

  let(:stream)   { Utils::Io::StreamInput.new(file_handle: file, sep: ',') }
  let(:file)     { 'spec/fixtures/05/input_1.csv' }
  let(:instance) { described_class.new('spec/fixtures/05/opcode_lang.yml', output_stream) }
  let(:output_stream) { OutputArray.new }

  before do
    allow(Operations::Input).to receive(:gets).and_return('1')
  end
  let(:loaded_instance) do
    instance.load(stream)
    instance
  end

  describe '#call' do
    subject { loaded_instance.call }

    it 'returns the updated tape' do
      expect(subject).to be_a Tape
      expect(subject.tape).to eq([1, 0, 4, 0, 99])
      expect(instance.outputs).to eq([1])
    end

    context 'diagnostics' do
      let(:file) { 'spec/fixtures/05/problem_1.csv' }

      it 'runs to completion' do
        subject.move_to(0)
        expect(instance.outputs[0...-1].all?(&:zero?)).to eq(true)
        expect(instance.outputs[-1]).to eq(15259545)
      end
    end
  end
end

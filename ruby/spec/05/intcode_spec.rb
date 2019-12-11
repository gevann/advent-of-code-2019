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
    allow(Operations::Input).to receive(:gets).and_return(input.to_s)
  end

  let(:input) { 1 }

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

    context 'with a program than checks if the input equals 8' do
      let(:stream) { [3, 9, 8, 9, 10, 9, 4, 9, 99, -1, 8] }

      context 'when it does not' do
        let(:input) { 5 }

        it 'outputs Operations::FALSE' do
          subject
          expect(instance.outputs.first).to eq(Operations::FALSE)
        end
      end

      context 'when it does' do
        let(:input) { 8 }

        it 'outputs Operations::TRUE' do
          subject
          expect(instance.outputs.first).to eq(Operations::TRUE)
        end
      end
    end

    context 'with a program that checks if the input is less than 8, using immediate mode' do
      let(:stream) { [3, 3, 1107, -1, 8, 3, 4, 3, 99] }

      context 'when it is not' do
        let(:input) { 8 }

        it 'outputs Operations::FALSE' do
          subject
          expect(instance.outputs.first).to eq(Operations::FALSE)
        end
      end

      context 'when it is' do
        let(:input) { 7 }

        it 'outputs Operations::TRUE' do
          subject
          expect(instance.outputs.first).to eq(Operations::TRUE)
        end
      end
    end

    context 'diagnostics' do
      let(:file) { 'spec/fixtures/05/problem_1.csv' }

      it 'runs to completion' do
        subject.move_to(0)
        expect(instance.outputs[0...-1].all?(&:zero?)).to eq(true)
        expect(instance.outputs[-1]).to eq(15259545)
      end

      context 'with input of the thermal radiator controller (5)' do
        let(:input) { 5 }

        it 'runs to completion' do
          subject.move_to(0)
          expect(instance.outputs[-1]).to eq(7616021)
        end
      end
    end
  end
end

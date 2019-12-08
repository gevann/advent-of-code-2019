require_relative '../../spec_helper'

require 'operations/output'
require 'tape'

RSpec.describe Operations::Output do
  describe '.call' do
    subject { described_class.call(tape, output_stream: output_stream) }
    let(:tape) { Tape.new(arr) }
    let(:arr)  { [1, 3, 3, 'test'] }
    let(:output_stream) { double('output', print: 'foo') }

    it 'writes to value to the output stream' do
      expect(output_stream).
        to receive(:print).with("test\n")

      subject
    end
  end
end

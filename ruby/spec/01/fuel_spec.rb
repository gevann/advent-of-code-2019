require_relative '../spec_helper'

require '01/fuel'
require 'utils/io/stream_input'

RSpec.describe Fuel do
  let(:instance) { described_class.new }
  let(:stream)   { Utils::Io::StreamInput.new(file_handle: file) }
  let(:file)     { 'spec/fixtures/01/input_1.txt' }

  describe '#counter_upper' do
    subject { instance.counter_upper(stream) }

    it 'calculates the total fuel needed' do
      expect(subject).to eq(3363929)
    end
  end
end

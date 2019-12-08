require_relative '../../spec_helper'

require 'operations/input'
require 'tape'

RSpec.describe Operations::Input do
  describe '.call' do
    subject { described_class.call(tape) }
    let(:tape) { Tape.new(arr) }
    let(:arr)  { [1, 3, 3, 4] }

    before do
      allow(Operations::Input).to receive(:gets).and_return('99')
    end

    it 'writes the input to the location' do
      expect { subject }.to change{arr}.
        to([1, 3, 3, 99])
    end
  end
end

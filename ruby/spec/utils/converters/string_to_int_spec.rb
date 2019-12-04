require_relative '../../spec_helper'

require 'utils/converters/string_to_int'

RSpec.describe Utils::Converters::StringToInt do
  let(:instance) { described_class.new }

  context 'class methods' do
    describe '.new' do
      subject { instance }
      it { is_expected.to be_a(Utils::Converters::StringToInt) }
    end
  end

  context 'instance methods' do
    describe '#convert' do
      subject { instance.convert(string: test_input) }
      let(:test_input) { '10\n' }

      it { is_expected.to eq(10) }
    end
  end
end

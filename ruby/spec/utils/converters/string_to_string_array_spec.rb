require_relative '../../spec_helper'

require 'utils/converters/string_to_string_array'

RSpec.describe Utils::Converters::StringToStringArray do
  let(:instance) { described_class.new }

  context 'class methods' do
    describe '.new' do
      subject { instance }
      it { is_expected.to be_a(Utils::Converters::StringToStringArray) }
    end
  end

  context 'instance methods' do
    describe '#convert' do
      subject { instance.convert(string: test_input) }
      let(:test_input) { "R1,D4,     D5" }

      it { is_expected.to eq(%w(R1 D4 D5)) }
    end
  end
end

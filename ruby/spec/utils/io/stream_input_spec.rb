require_relative '../../spec_helper'

require 'utils/io/stream_input'

RSpec.describe Utils::Io::StreamInput do
  let(:instance) { described_class.new(file_handle: file) }
  let(:file)     { 'spec/fixtures/io/stream_input_file.txt' }

  context 'class methods' do
    describe '.new' do
      subject { instance }

      it { is_expected.to be_a(Utils::Io::StreamInput) }

      context 'with a file handle for a file that cannot be found' do
        let(:file) { 'foo/bar.txt' }
        it 'raise an argument error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end
  end

  context 'instance methods' do
    describe '.to_sym' do
      subject { instance.to_sym }

      it { is_expected.to eq(:'spec/fixtures/io/stream_input_file.txt') }
    end

    describe '.each' do
      subject { instance.each }

      it { is_expected.to be_a Enumerator }
    end
  end
end

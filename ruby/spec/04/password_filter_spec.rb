require_relative '../spec_helper'

require '04/password_filter'

RSpec.describe PasswordFilter do
  let(:instance) { described_class.new(range) }
  let(:range) { (138241..674034) }

  describe '.call' do
    subject { instance.call }
    it 'returns the filtered results' do
      expect(subject.length).to eq(1277)
    end
  end
end

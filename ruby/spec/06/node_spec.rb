require_relative '../spec_helper'

require 'node'

RSpec.describe Node do
  describe '.new' do
    subject { Node.new(name: :COM) }
    it { is_expected.to be_a Node }

    it 'has the correct attributes' do
      expect(subject).to have_attributes(
        name: :COM,
        parent: nil,
      )
    end
  end

  describe '#flat_map' do
    subject { instance.flat_map(&:name) }
    let(:a) { Node.new(name: :A) }
    let(:b) { Node.new(name: :B) }
    let(:c) { Node.new(name: :C) }
    let(:instance) do
      Node.new(name: :D)
    end

    before do
      b.parent = a
      c.parent = b
      instance.parent = c
    end

    it { is_expected.to eq([:A, :B, :C, :D])}
  end
end

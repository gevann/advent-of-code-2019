require_relative '../spec_helper'

require 'node'

RSpec.describe Node do
  describe '.new' do
    subject { Node.new(name: :COM) }
    it { is_expected.to be_a Node }

    it 'has the correct attributes' do
      expect(subject).to have_attributes(
        name: :COM,
        directly_adjacent_nodes: [],
        directly_adjacent_node_count: 0,
        indirectly_adjacent_node_count: 0
      )
    end
  end
end

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

  describe '#add_nodes' do
    subject        { instance.add_nodes(node)        }
    let(:instance) { described_class.new(name: :COM) }
    let(:node)     { described_class.new(name: :B)   }

    it "adds the new nodes to the instance's adjacent nodes" do
      expect { subject }.
        to change { instance.directly_adjacent_nodes }.
        from([]).to([node])
    end

    it "updates the adjacent node count" do
      expect { subject }.
        to change { instance.directly_adjacent_node_count }.
        from(0).to(1)
    end
  end
end

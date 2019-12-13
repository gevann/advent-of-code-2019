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

  describe '.dfs_count' do
    subject { described_class.dfs_count(instance) }

    context 'without children' do
      let(:instance) { Node.new(name: :COM) }
      it { is_expected.to eq(0) }

      context 'with children' do
        let(:instance) { Node.new(name: :COM).add_nodes(bnodes) }
        let(:bnodes) do
          [
            Node.new(name: :B1),
            Node.new(name: :B2).add_nodes(cnodes),
          ]
        end
        let(:cnodes) { Node.new(name: :C1) }

        it { is_expected.to eq(3) }
      end
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

  describe '#increment_indirect_count' do
    subject        { instance.increment_indirect_count }
    let(:instance) { described_class.new(name: :COM)   }

    it 'increments the count' do
      expect { subject }.
        to change { instance.indirectly_adjacent_node_count }.by(1)
    end
  end
end

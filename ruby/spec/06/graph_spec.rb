require_relative '../spec_helper'

require 'graph'

RSpec.describe Graph do
  let(:instance) { Graph.new(root) }
  let(:root)     { Node.new(name: :COM).add_nodes(anodes)  }
  let(:anodes) do
    [
      Node.new(name: :A1).add_nodes(bnodes),
      Node.new(name: :A2).add_nodes(cnodes),
    ]
  end
  let(:bnodes) { Node.new(name: :B1).add_nodes(dnodes) }
  let(:cnodes) { Node.new(name: :C1) }
  let(:dnodes) { Node.new(name: :D1) }

  describe "#dfs" do
    subject { instance.dfs(:D1, root, [root]) }

    it 'returns the path to the node' do
      expect( subject.map(&:name) ).to eq([:COM, :A1, :B1, :D1])
    end
  end
end

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

  describe "insert_edge" do
    subject        { edges.each { |tuple| instance.insert_edge(*tuple) } }
    let(:instance) { Graph.new(root)      }
    let(:root)     { Node.new(name: :COM) }
    let(:edges) do
      [
        [:COM,:B],
        [:B,:C],
        [:C,:D],
        [:D,:E],
        [:E,:F],
        [:B,:G],
        [:G,:H],
        [:D,:I],
        [:E,:J],
        [:J,:K],
        [:K,:L],
      ]
    end

    it 'updates the orbit count on insertion' do
      subject
      expect(instance.orbit_count).to eq(42)
    end
  end
end

require_relative '../spec_helper'

require 'graph'

RSpec.describe Graph do
  let(:instance) { Graph.new }
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

  describe "#count_orbits" do
    before do
      stream.each do |tuple|
        instance.insert_edge(*tuple)
      end
    end
    subject        { instance.count_orbits }
    let(:instance) { Graph.new      }

    let(:instance) { Graph.new }
    let(:root) { Node.new(name: :COM) }
    let(:stream) do
      Utils::Io::StreamInput.new(
        file_handle: 'spec/fixtures/06/problem_1.csv',
        converter: Utils::Converters::StringToSymbolArray.new
      )
    end

    it { is_expected.to eq(249308) }
  end
end

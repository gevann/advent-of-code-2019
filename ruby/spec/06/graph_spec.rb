require_relative '../spec_helper'

require 'graph'

RSpec.describe Graph do
  let(:instance) { Graph.new }
  let(:root) { Node.new(name: :COM) }

  before do
    stream.each do |tuple|
      instance.insert_edge(*tuple)
    end
  end
  let(:stream) do
    Utils::Io::StreamInput.new(
      file_handle: 'spec/fixtures/06/problem_1.csv',
      converter: Utils::Converters::StringToSymbolArray.new
    )
  end

  describe '#BFS' do
    subject { instance.BFS(from: :COM, to: :SAN).flat_map(&:name) }
    let(:stream) do
      [
        [:COM, :B],
        [:B, :C],
        [:C, :D],
        [:D, :E],
        [:E, :F],
        [:B, :G],
        [:G, :H],
        [:D, :I],
        [:E, :J],
        [:J, :K],
        [:K, :L],
        [:K, :YOU],
        [:I, :SAN],
      ]
    end
    it { is_expected.to eq([:COM, :B, :C, :D, :I, :SAN]) }
  end

  describe "#count_orbits" do
    subject { instance.count_orbits }
    it { is_expected.to eq(249308) }
  end

  describe '#distance' do
    subject { instance.distance(from: :SAN, to: :YOU) }

    it { is_expected.to eq(349) }
  end
end

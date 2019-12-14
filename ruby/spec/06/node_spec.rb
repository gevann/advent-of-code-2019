require_relative '../spec_helper'

require 'node'

RSpec.describe Node do
  describe '.new' do
    subject { Node.new(name: :COM) }
    it { is_expected.to be_a Node }

    it 'has the correct attributes' do
      expect(subject).to have_attributes(
        name: :COM,
        children: [],
      )
    end
  end

  describe '.dfs_count' do
    subject { described_class.dfs_count(instance) }

    context 'without children' do
      let(:instance) { Node.new(name: :COM) }
      it { is_expected.to eq(0) }

      context 'with children' do
        let(:instance) { Node.new(name: :COM).add_children(bnodes) }
        let(:bnodes) do
          [
            Node.new(name: :B1),
            Node.new(name: :B2).add_children(cnodes),
          ]
        end
        let(:cnodes) { Node.new(name: :C1) }

        it { is_expected.to eq(3) }
      end
    end
  end

  describe '#add_children' do
    subject        { instance.add_children(node)        }
    let(:instance) { described_class.new(name: :COM) }
    let(:node)     { described_class.new(name: :B)   }

    it "adds the new nodes to the instance's children" do
      expect { subject }.
        to change { instance.children }.
        from([]).to([node])
    end
  end
end

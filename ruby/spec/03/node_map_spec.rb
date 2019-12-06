require_relative '../spec_helper'

require '03/point'
require '03/node_map'

RSpec.describe NodeMap do
  let(:instance) { described_class.new }
  let(:point)    { Point.new(3, 4) }
  let(:other_point) { Point.new(0, 0) }

  describe '.visit' do
    context 'with the same path id' do

      before { instance.path_id = :first_path }

      it 'marks each visit' do
        instance.visit(point)
        expect(instance[point]).to eq(1)
        instance.visit(point)
        expect(instance[point]).to eq(1)
      end

      it 'adds the path position to the point' do
        instance.visit(point)
        instance.visit(other_point)
        expect(instance.visit_count(1).last.path_position).to eq(2)
      end
    end

    context 'when the path id changes' do
      before { instance.path_id = :first_path }

      it 'marks each visit' do
        instance.visit(point)
        expect(instance[point]).to eq(1)

        instance.path_id = :second_path

        instance.visit(point)
        expect(instance[point]).to eq(2)
      end
    end
  end

  describe '.visit_count' do
    let(:other_point) { Point.new(0, 0) }
    let(:final_point) { Point.new(9, 9) }

    it 'returns all points visited <count> many times' do
      instance.visit(point)
      instance.path_id = :second_path
      instance.visit(point)

      instance.visit(other_point)

      instance.visit(final_point)
      instance.path_id = :first_path
      instance.visit(final_point)

      expect(instance.visit_count(2)).to contain_exactly(point, final_point)
    end
  end
end

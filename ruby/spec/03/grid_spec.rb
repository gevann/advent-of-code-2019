require_relative '../spec_helper'

require '03/grid'
require '03/distance/manhattan'

RSpec.describe Grid do
  let(:instance) { described_class.new }

  describe '#trace' do
    subject { instance.trace(path) }
    let(:path) { %w(R2 U1 L1 D2) }

    it { is_expected.to be_a(NodeMap) }
  end

  describe '#intersections' do
    let(:path) { %w(R2 U1 L1 D2) }
    let(:stream) do
      Utils::Io::StreamInput.new(
        file_handle: file,
        converter: Utils::Converters::StringToStringArray.new
      )
    end
    let(:file)   { 'spec/fixtures/03/input_1.csv' }

    it 'returns the intersections' do
      stream.each { |path| path && instance.trace(path) }

      origin = Point.new(0, 0)

      min_distance = instance.intersections.map do |point|
        Distance::Manhattan.calculate(origin, point)
      end.min

      expect(min_distance).to eq(709)
    end

    it 'does the thing' do
      paths = [
        "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51".split(","),
        "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7".split(",")
      ]

      paths.each { |path| instance.trace(path) }

      origin = Point.new(0, 0)

      min_distance = instance.intersections.map do |point|
        Distance::Manhattan.calculate(origin, point)
      end.min

      expect(min_distance).to eq(135)
    end
  end
end

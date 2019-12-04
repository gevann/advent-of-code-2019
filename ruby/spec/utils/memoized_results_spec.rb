require_relative '../spec_helper'

require 'utils/memoized_results'

RSpec.describe MemoizedResults do
  TestableClass = Class.new do
    include MemoizedResults

    def initialize(callable_spy)
      @callable_spy = callable_spy
    end

    def memoized_method
      memoized_results(@callable_spy, __callee__) do
        @callable_spy.call
      end
    end
  end

  CallableSpy = Class.new do
    def initialize
      @call_count = 0
    end

    def to_sym
      :spy
    end

    def call(*args)
      @call_count += 1

      1234
    end

    attr_reader :call_count
  end

  let(:instance) { TestableClass.new(callable_instance) }
  let(:callable_instance) { CallableSpy.new }

  describe '#memoized_method' do
    it 'memoizes the results' do
      expect(instance.memoized_method).to eq(1234)
      expect(callable_instance.call_count).to eq(1)

      expect(instance.memoized_method).to eq(1234)
      expect(callable_instance.call_count).to eq(1)
    end
  end
end

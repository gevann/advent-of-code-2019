module MemoizedResults
  private

  def memoized_results(id_able, callee)
    @memoized_results ||= Hash.new { |h, k| h.store(k, {}) }

    for_callee = @memoized_results[callee]
    id = id_able.to_sym

    if (previously_computed_result = for_callee[id])
      previously_computed_result
    else
      result = yield
      for_callee.store(id, result)
    end
  end
end

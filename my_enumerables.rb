module Enumerable
  def my_each
    return nil unless block_given?

    idx = 0
    while idx < length
      yield self[idx]
      idx += 1
    end
    self
  end

  def my_each_with_index
    return nil unless block_given?

    idx = 0
    while idx < length
      yield self[idx], idx
      idx += 1
    end
    self
  end
end
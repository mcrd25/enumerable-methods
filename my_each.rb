module Enumerable
  def my_each
    return nil unless block_given?

    idx = 0
    while idx < length
      yield self[idx]
      idx += 1
    end
  end
end
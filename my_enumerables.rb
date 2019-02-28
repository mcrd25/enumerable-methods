module Enumerable
  def my_each
    return to_enum unless block_given?

    idx = 0
    while idx < length
      yield self[idx]
      idx += 1
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    idx = 0
    my_each do |item|
      yield item, idx
      idx += 1
    end
    self
  end

  def my_map
    return to_enum unless block_given?

    arr = []
    my_each do |item|
      arr.push(yield(item))
    end
    arr
  end

end
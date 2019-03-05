module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    idx = 0
    while idx < length
      yield self[idx]
      idx += 1
    end
    self
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    idx = 0
    my_each { |item| yield item, idx, idx += 1 }
    self
  end

  def my_select
    return to_enum :my_select unless block_given?

    arr = []
    my_each { |item| arr << item if yield(item) == true }
    arr
  end

  def my_all?
    my_each { |item| return false if yield(item) == false } if block_given?
    my_each { |item| return false if !item } if !block_given?
    true
  end

  def my_any?
    my_each { |item| return true if yield(item) == true } if block_given?
    my_each { |item| return true if item } if !block_given?
    false
  end

  def my_none?
    my_each { |item| return false if yield(item) != false } if block_given?
    my_each { |item| return false if item } if !block_given?
    true
  end

  def my_count(arg = nil)
    c = 0
    if block_given?
      my_each { |item| c += 1 if yield(item) == true }
    else
      return length if arg.nil?

      my_each { |item| c += 1 if item == arg }
    end
    c
  end

  def my_map
    return to_enum unless block_given?

    arr = []
    my_each { |item| arr << yield(item) }
    arr
  end

  def my_inject
  end  
end

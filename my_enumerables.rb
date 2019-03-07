module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

    new_self = is_a?(Range) ? to_a : self
    i = 0
    while i < new_self.length
      yield(new_self[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum :my_each_with_index unless block_given?

    i = 0
    my_each { |item| yield item, i, i += 1 }
    self
  end

  def my_select
    return to_enum :my_select unless block_given?

    return_arr = []
    my_each { |item| return_arr << item if yield(item) }
    return_arr
  end

  def my_all?(pattern = nil)
    all_true = true
    if block_given?
      my_each { |item| unless yield(item) then all_true=false; break end }
    elsif pattern
      my_each { |item| unless pattern === item then all_true=false; break end }
    else
      my_each { |item| unless item  then all_true=false; break end }
    end
    all_true

    # if block_given?
    #   my_each { |item| return false if yield(item) == false }
    # elsif pattern
    #   my_each { |item| return false unless item === pattern }
    # else
    #   my_each { |item| return false unless item }
    # end
    # true
  end

  def my_any?(pattern = nil)
    any_true = false
    if block_given?
      my_each { |item| if yield(item) then any_true=true; break end }
    elsif pattern
      my_each { |item| if pattern === item then any_true=true; break end }
    else
      my_each { |item| if item then any_true=true; break end }
    end
    any_true
  end

  def my_none?(pattern = nil, &block)
    !my_any?(pattern, &block)
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
    return to_enum :my_map unless block_given?

    # new_self = is_a?(Range) ? to_a : self

    return_arr = []
    my_each { |item| return_arr << yield(item) }
    return_arr
  end

  def my_inject(arg1 = nil, arg2 = nil)
    new_self = is_a?(Range) ? to_a : self
    # accumulator ||= new_self[0]
    # if block_given?
    #   new_self[1..-1].my_each { |item| accumulator = yield(accumulator, item) }
    # elsif sym
    #   new_self[1..-1].my_each do |i|
    #     accumulator = accumulator.send(sym, i)
    #   end
    # end
    # accumulator
    arg1.is_a?(Integer || Float)
    accumulator = new_self[0] if arg1.nil? || arg1.is_a?(Symbol)
    new_self.my_each { |item| accumulator = yield(accumulator, item) }
    new_self[1..-1].my_each { |i| accumulator = accumulator.send(arg1, i) } if arg1.is_a?(Symbol)
    new_self[1..-1].my_each { |i| accumulator = accumulator.send(arg1, i) } if arg2.is_a?(Symbol)
    accumulator
  end

  def multiply_els
    my_inject(1) { |total, item| total * item }
  end
end
module Enumerable
  def my_each
    return to_enum unless block_given?

    if self.class == Range
        new_self = self.to_a
    else 
        new_self = self
    end
    i = 0
    while i < new_self.size
        yield(new_self[i])  
        i+=1      
    end
    self
  end
  def my_each_with_index
    return to_enum unless block_given?
    i = 0
    while i < self.size
        yield(self[i], i)
        i += 1
    end
    self
  end  

  def my_select 
    return to_enum unless block_given?
    return_arr = []
    self.my_each { |item| return_arr << item if yield(item) }
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

  # opposite of my_any? as at least one is true it is automatically false 
  # if none is true then all are false then my_none would be true
  def  my_none?(pattern = nil, &block)
    !(my_any?(pattern,&block)) 
  end

  def my_count(arg=nil)
    count = 0
    if block_given?
        my_each { |item| if yield(item) then count += 1 end}
    elsif arg
        my_each { |item| if item == arg  then count += 1 end}
    else
        count = self.length
    end
    count
  end
  
  def my_map
    return to_enum unless block_given?
    return_arr = []
    my_each {|item| return_arr << yield(item) }
    return_arr
  end

  def my_inject(arg1=nil, arg2 = nil)
    if self.class == Range
        new_self = self.to_a
    else 
        new_self = self
    end
    memo = (arg1  == nil || arg1.class == Symbol) ? new_self[0] : arg1
    if block_given?
      new_self[1..-1].my_each { |item| memo = yield(memo, item) } 
    elsif arg1 && arg1.class == Symbol
        new_self[1..-1].my_each do |i|
            memo = memo.send(arg1, i)
        end
    elsif arg2
      new_self[0..-1].my_each do |i|
          memo = memo.send(arg2, i)
      end
    end
    memo
  end

end
arr = [5, 6, 7, 8, 9, 10]
def multiply_els(arr)
    return arr.my_inject(1, :*)
end
puts multiply_els(arr)
puts (5..10).my_inject(1, :*)    
longest = %w{ cat sheep bear }.my_inject do |memo, word|
   memo.length > word.length ? memo : word
end
puts longest
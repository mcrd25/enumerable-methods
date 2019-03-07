require 'minitest/autorun'
load './my_enumerables.rb'

class MyEnumerablesTest < Minitest::Test
  def test_my_each
    assert_equal([1, 2, 3], [1, 2, 3].my_each { |i| i * 2 })
    assert_output('246') { [1, 2, 3].my_each { |i| print i * 2 } }
    assert([1, 2, 3].my_each.is_a?(Enumerator))
  end

  def test_my_each_with_index
  	assert_output('102132') { [1, 2, 3].my_each_with_index { |i, index| print i, index } }
    assert([1, 2, 3].my_each_with_index.is_a?(Enumerator))

  	assert_equal([1, 2, 3].each_with_index { |i| i * 2 }, [1, 2, 3].my_each_with_index { |i| i * 2 })
    assert_equal([1, 2, 3], [1, 2, 3].my_each_with_index { |i| i * 2 })
    assert_equal([1, 2, 3].my_each_with_index.is_a?(Enumerator), [1, 2, 3].my_each_with_index.is_a?(Enumerator))

    
  end

  def test_my_select
    assert_equal([2, 4], [2, 3, 4].my_select(&:even?))
    assert_equal([2, 4], [2, 3, 4].my_select { |num| num.even? })
    assert([1, 2, 3].my_select.is_a?(Enumerator))

    assert_equal([2, 3, 4].select { |num| num.even? }, [2, 3, 4].my_select { |num| num.even? })
    assert_equal([2, 3, 4].select(&:even?), [2, 3, 4].my_select(&:even?))
  end

  def test_my_all?    
    assert(%w[ant bear cat].my_all? { |word| word.length >= 3 })
    assert(!%w[ant bear cat].my_all? { |word| word.length >= 4 })
    assert(![nil, true, 99].my_all?)
    assert([].my_all?)

    assert_equal(%w[ant bear cat].my_all? { |word| word.length >= 3 }, %w[ant bear cat].all? { |word| word.length >= 3 })
    assert_equal(%w[ant bear cat].my_all? { |word| word.length >= 4 }, %w[ant bear cat].all? { |word| word.length >= 4 })
    assert_equal([nil, true, 99].my_all?, [nil, true, 99].all?)
    assert_equal([].my_all?, [].all?)
    assert_equal([1, 2i, 3.14].my_all?(Numeric), [1, 2i, 3.14].all?(Numeric))
    assert_equal(%w[ant bear cat].my_all?(/t/), %w[ant bear cat].all?(/t/))
  end

  def test_my_any?
  	assert_equal(%w[ant bear cat].my_any? { |word| word.length >= 3 }, %w[ant bear cat].any? { |word| word.length >= 3 })
    assert_equal(%w[ant bear cat].my_any? { |word| word.length >= 4 }, %w[ant bear cat].any? { |word| word.length >= 4 })
    assert_equal([nil, true, 99].my_any?, [nil, true, 99].any?)
    assert_equal([].my_any?, [].any?)
    assert_equal(%w[ant bear cat].my_any?(/d/), %w[ant bear cat].any?(/d/))
  end
 
  def test_my_none?
  	assert_equal(%w[ant bear cat].my_none? { |word| word.length >= 5 }, %w[ant bear cat].none? { |word| word.length >= 5 })
  	assert_equal(%w[ant bear cat].my_none? { |word| word.length >= 4 }, %w[ant bear cat].none? { |word| word.length >= 4 })
  	assert_equal([].my_none?, [].none?)
  	assert_equal([nil].my_none?, [nil].none?)
  	assert_equal([nil, false].my_none?, [nil, false].none?)
  	assert_equal([nil, false, true].my_none?, [nil, false, true].none?)
  	#assert_equal(%w{ant bear cat}.my_none?(/d/), %w{ant bear cat}.none?(/d/))
  end

  def test_my_count
  	ary = [1, 2, 4, 2]
  	assert_equal(4, ary.my_count)
  	assert_equal(2, ary.my_count(2))
  	assert_equal(3, ary.my_count(&:even?))

  	assert_equal(ary.count, ary.my_count)
  	assert_equal(ary.count(2), ary.my_count(2))
  	assert_equal(ary.my_count(&:even?), ary.my_count(&:even?))
  end

  def test_my_map
  	assert_equal([1, 4, 9, 16], [1, 2, 3, 4].my_map { |i| i * i })
  	assert_equal([1, 4, 9, 16], (1..4).my_map { |i| i * i })
  	assert_equal((1..4).map { |i| i * i }, [1, 2, 3, 4].my_map { |i| i * i })
  	assert_equal(["1", "2"], [1, 2].my_map(&:to_s))
  	#assert_equal(["1", "2"], [1, 2].my_map(&:to_s) { |i| i * 2 })
  end

  def test_my_inject
  	assert_equal((1..3).inject(1) { |product, n| product * n }, (1..3).my_inject(1) { |product, n| product * n })
    #assert_equal(6, (1..3).my_inject(1) { |product, n| product * n })
  end

  def test_multiply_els
    assert_equal(40, [2, 4, 5].multiply_els)
  end
end
require './my_enumerables.rb'

describe Enumerable do
  let(:test_arr) { [1, 2, 3] }
  let(:test_block) { proc { |i| i * 2 } }
  let(:ant_bear_cat) { %w[ant bear cat] }
  let(:len_block_three) { proc { |word| word.length >= 3 } }
  let(:len_block_five) { proc { |word| word.length >= 5 }  }
  let(:test_range) { (1..4) }
  let(:test_absolutes) { [nil, true, false] }
  let(:test_numeric) { [1, 2i, 3.14] }

  describe '#my_each' do
    it 'returns original array when no output' do
      expect(test_arr.my_each { test_block }).to eq(test_arr)
    end

    it 'prints result to stdout from block calculation i * 2' do
      expect { test_arr.my_each { |i| print i * 2 } }.to output(/246/).to_stdout
    end

    it 'returns an Enumerator when no block given' do
      expect(test_arr.my_each.is_a?(Enumerator)).to be(true)
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(test_arr.my_each { test_block }).to eq(test_arr.each { test_block })
      expect(test_arr.my_each.is_a?(Enumerator)).to eq(test_arr.each.is_a?(Enumerator))
    end
  end

  describe '#my_each_with_index' do
    it 'returns original array when no output' do
      expect(test_arr.my_each_with_index { test_block }).to eq(test_arr)
    end

    it 'prints item and index to stdout from block' do
      expect { test_arr.my_each_with_index {|i, index| print i, index } }.to output(/102132/).to_stdout
      
    end

    it 'returns an Enumerator when no block given' do
      expect(test_arr.my_each_with_index.is_a?(Enumerator)).to be true
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(test_arr.my_each_with_index { test_block }).to eq(test_arr.each_with_index { test_block })
      expect(test_arr.my_each_with_index.is_a?(Enumerator)).to eq(test_arr.each_with_index.is_a?(Enumerator))
    end
  end

  describe '#my_select' do
    it 'returns even numbers from array of numbers' do
      expect(test_arr.my_select(&:even?)).to eq([2])
    end

    it 'returns an Enumerator when no block given' do
      expect(test_arr.my_select.is_a?(Enumerator)).to be(true)
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(test_arr.my_select(&:even?)).to eq(test_arr.select(&:even?))
      expect(test_arr.my_select.is_a?(Enumerator)).to eq(test_arr.select.is_a?(Enumerator))
    end
  end

  

  describe '#my_all?' do 
    it 'returns true when all array items match given condition' do
      expect(ant_bear_cat.my_all?(&len_block_three)).to be true
    end

    it 'returns false when all array items does not match given condition' do
      expect(ant_bear_cat.my_all?(&len_block_five)).to be false
    end

    it 'returns false when no block given and one item is nil or false' do 
      expect(test_absolutes.my_all?).to be false
    end

    it 'returns true when no block given all items are neither nil or false' do 
      expect(test_arr.my_all?).to be true
    end

    it 'returns true with an empty array (it is neither false or nil)' do
      expect([].my_all?).to be true
    end

    it 'returns true when all array items are of a given type' do
      expect(test_numeric.my_all?(Numeric)).to be true
    end

    it 'returns false when all array items do not match a given pattern' do
      expect(ant_bear_cat.my_all?(/t/)).to eq false
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(ant_bear_cat.my_all?(&len_block_three)).to eq(%w[ant bear cat].all?(&len_block_three))
      expect(ant_bear_cat.my_all?(&len_block_five)).to eq(%w[ant bear cat].all?(&len_block_five))
      expect(test_absolutes.my_all?).to eq(test_absolutes.all?)
      expect(test_arr.my_all?).to eq(test_arr.all?)
      expect([].my_all?).to eq([].all?)
      expect(test_numeric.my_all?(Numeric)).to eq(test_numeric.my_all?(Numeric))
      expect(ant_bear_cat.my_all?(/t/)).to eq(%w[ant bear cat].all?(/t/))
    end
  end

  describe '#my_any' do 
    it 'returns true when at least one item matches given condition' do
      expect(ant_bear_cat.my_any?(&len_block_three)).to be true
    end
    it 'returns false when no item matches given condition' do
      expect(ant_bear_cat.my_any?(&len_block_five)).to be false
    end

    it 'returns true when no block given and at least one item neither nil or false' do
      expect(test_absolutes.my_any?).to eq true
    end

    it 'returns false when given an empty array (at least one item being neither nil or false)' do
      expect([].my_any?).to eq false
    end

    it 'returns false when no item matches a given pattern' do
      expect(%w[ant bear cat].my_any?(/d/)).to eq false
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(ant_bear_cat.my_any?(&len_block_three)).to eq(ant_bear_cat.any?(&len_block_three))
      expect(ant_bear_cat.my_any?(&len_block_five)).to eq(ant_bear_cat.any?(&len_block_five))
      expect(test_absolutes.my_any?).to eq(test_absolutes.any?)
      expect([].my_any?).to eq([].any?)
      expect(ant_bear_cat.my_any?(/d/)).to eq(ant_bear_cat.any?(/d/))
    end
  end 
  
describe '#my_none' do 
    it 'returns false when all items match a given condition' do
      expect(ant_bear_cat.my_none?(len_block_three)).to be false
    end
    it 'returns true when all items do not match a given condition' do
      expect(ant_bear_cat.my_none?(len_block_five)).to be true
    end

    it 'returns false when no block given and all items are neither nil or false' do
      expect(test_absolutes.my_none?).to eq false
    end

    it 'returns true when no block given with an empty array' do
      expect([].my_none?).to eq true
    end

    it 'returns true when all items do not match a given pattern' do
      expect(ant_bear_cat.my_none?(/d/)).to eq true
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(ant_bear_cat.my_none?(&len_block_three)).to eq(ant_bear_cat.none?(&len_block_three))
      expect(ant_bear_cat.my_none?(&len_block_five)).to eq(ant_bear_cat.none?(&len_block_five))
      expect(test_absolutes.my_none?).to eq(test_absolutes.none?)
      expect([].my_none?).to eq([].none?)
      expect(ant_bear_cat.my_none?(/d/)).to eq(ant_bear_cat.none?(/d/))
    end
  end
  
  describe '#my_count' do
    it 'returns array length when no block given' do
      expect(test_arr.my_count).to eq(3)
    end

    it 'returns the number of items that match the positional argument given' do 
      expect(test_arr.my_count(2)).to eq(1)
    end

    it 'returns the number of items that match a given block condition' do
      expect(test_arr.my_count(&:odd?)).to eq(2)
    end    

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(test_arr.my_count).to eq(test_arr.count)
      expect(test_arr.my_count(2)).to eq(test_arr.count(1))
      expect(test_arr.my_count(&:odd?)).to eq(test_arr.count(&:odd?))
    end
  end

  describe '#my_map' do
    it 'returns a modified array resulting from block operation' do
      expect(test_arr.my_map(&test_block)).to eq([2, 4, 6])
    end

    it 'returns modified array when given a range with a block' do
      expect(test_range.my_map(&test_block)).to eq([2, 4, 6, 8])
    end

    it 'returns array of strings when given array of integers' do
      expect(test_arr.my_map(&:to_s)).to eq(['1', '2', '3'])
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(test_arr.my_map(&:to_s)).to eq(test_arr.map(&:to_s))
      expect(test_range.my_map { test_block }).to eq(test_range.map { test_block })
      expect(test_arr.my_map { test_block }).to eq(test_arr.map { test_block })
    end
  end

  describe '#my_inject' do
    let(:cat_sheep_bear) { %w{ cat sheep bear } }
    it 'returns the accumulative result when given a starting value and a block operation' do
      expect(test_range.my_inject(1) { |product, n| product * n }).to eq(24)
    end

    it 'returns the accumulative result when given starting value and a urnary operator' do
      expect(test_range.my_inject(1, :*)).to eq(24)
    end

    it 'returns result when given a block condition against a neighboring item' do
      expect(cat_sheep_bear.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eq 'sheep'
    end
  
    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(test_range.my_inject(1) { |product, n| product * n }).to eq(test_range.inject(1) { |product, n| product * n })
      expect(test_range.my_inject(1, :*)).to eq(test_range.inject(1, :*))
      expect(cat_sheep_bear.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eq(cat_sheep_bear.inject { |memo, word| memo.length > word.length ? memo : word })
    end
  end

  describe '#multiply_els' do
    it 'returns result of function that uses #my_inject to multiply all items' do
      expect(test_arr.multiply_els).to eq(6)
    end
  end
end

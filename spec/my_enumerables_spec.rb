require './my_enumerables.rb'

describe Enumerable do
  context '#my_each' do
    it 'returns original array when no output' do
      expect([1, 2, 3].my_each { |i| i * 2 }).to eq [1, 2, 3]
    end

    it 'prints result to stdout from block calculation i * 2' do
      expect { [1, 2, 3].my_each { |i| print i * 2 } }.to output(/246/).to_stdout
    end

    it 'returns an Enumerator when no block given' do
      expect([1, 2, 3].my_each.is_a?(Enumerator)).to be true
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect([1, 2, 3].my_each { |i| i * 2 }).to eq([1, 2, 3].each { |i| i * 2 })
      expect { [1, 2, 3].each { |i, index| print i * 2 } }.to output(/246/).to_stdout
      expect([1, 2, 3].my_each.is_a?(Enumerator)).to eq([1, 2, 3].each.is_a?(Enumerator))
    end
  end

  context '#my_each_with_index' do
    it 'returns original array when no output' do
      expect([1, 2, 3].my_each_with_index { |i| i * 2 }).to eq [1, 2, 3]
    end

    it 'prints item and index to stdout from block' do
      expect { [1, 2, 3].my_each_with_index {|i, index| print i, index} }.to output(/102132/).to_stdout
      
    end

    it 'returns an Enumerator when no block given' do
      expect([1, 2, 3].my_each_with_index.is_a?(Enumerator)).to be true
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect([1, 2, 3].my_each_with_index { |i| i * 2 }).to eq([1, 2, 3].each_with_index { |i| i * 2 })
      expect { [1, 2, 3].each_with_index {|i, index| print i, index} }.to output(/102132/).to_stdout
      expect([1, 2, 3].my_each_with_index.is_a?(Enumerator)).to eq([1, 2, 3].each_with_index.is_a?(Enumerator))
    end
  end

  context '#my_select' do
    it 'returns even numbers from array of numbers' do
      expect([1, 2, 3, 4].my_select(&:even?)).to eq [2, 4]
    end

    it 'returns an Enumerator when no block given' do
      expect([1, 2, 3].my_select.is_a?(Enumerator)).to be true
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect([1, 2, 3, 4].my_select(&:even?)).to eq([1, 2, 3, 4].select(&:even?))
      expect([1, 2, 3].my_select.is_a?(Enumerator)).to eq([1, 2, 3].select.is_a?(Enumerator))
    end
  end

  context '#my_all?' do 
    it 'returns true when all array items match given condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to be true
    end

    it 'returns false when all array items does not match given condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to be false
    end

    it 'returns false when no block given and one item is nil or false' do 
      expect([nil, true, 99].my_all?).to be false
    end

    it 'returns true when no block given all items are neither nil or false' do 
      expect([0, 1, 2].my_all?).to be true
    end

    it 'returns true with an empty array (it is neither false or nil)' do
      expect([].my_all?).to be true
    end

    it 'returns true when all array items are of a given type' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to be true
    end

    it 'returns false when all array items do not match a given pattern' do
      expect(%w[ant bear cat].my_all?(/t/)).to eq false
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eq(%w[ant bear cat].all? { |word| word.length >= 3 })
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eq(%w[ant bear cat].all? { |word| word.length >= 4 })
      expect([nil, true, 99].my_all?).to eq([nil, true, 99].all?)
      expect([0, 1, 2].my_all?).to eq([0, 1, 2].all?)
      expect([].my_all?).to eq([].all?)
      expect([1, 2i, 3.14].my_all?(Numeric)).to eq([1, 2i, 3.14].my_all?(Numeric))
      expect(%w[ant bear cat].my_all?(/t/)).to eq(%w[ant bear cat].all?(/t/))
    end
  end

  context '#my_any' do 
    it 'returns true when at least one item matches given condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to be true
    end
    it 'returns false when no item matches given condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to be false
    end

    it 'returns true when no block given and at least one item neither nil or false' do
      expect([nil, true, false].my_any?).to eq true
    end

    it 'returns false when given an empty array (at least one item being neither nil or false)' do
      expect([].my_any?).to eq false
    end

    it 'returns false when no item matches a given pattern' do
      expect(%w[ant bear cat].my_any?(/d/)).to eq false
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eq(%w[ant bear cat].any? { |word| word.length >= 3 })
      expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to eq(%w[ant bear cat].any? { |word| word.length >= 5 })
      expect([nil, true, false].my_any?).to eq([nil, true, false].any?)
      expect([].my_any?).to eq([].any?)
      expect(%w[ant bear cat].my_any?(/d/)).to eq(%w[ant bear cat].any?(/d/))
    end
  end 

  context '#my_none' do 
    it 'returns false when all items match a given condition' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 3 }).to be false
    end
    it 'returns true when all items do not match a given condition' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 5 }).to be true
    end

    it 'returns false when no block given and all items are neither nil or false' do
      expect([nil, true, false].my_none?).to eq false
    end

    it 'returns true when no block given with an empty array' do
      expect([].my_none?).to eq true
    end

    it 'returns true when all items do not match a given pattern' do
      expect(%w[ant bear cat].my_none?(/d/)).to eq true
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect(%w[ant bear cat].my_none? { |word| word.length >= 3 }).to eq(%w[ant bear cat].none? { |word| word.length >= 3 })
      expect(%w[ant bear cat].my_none? { |word| word.length >= 5 }).to eq(%w[ant bear cat].none? { |word| word.length >= 5 })
      expect([nil, true, false].my_none?).to eq([nil, true, false].none?)
      expect([].my_none?).to eq([].none?)
      expect(%w[ant bear cat].my_none?(/d/)).to eq(%w[ant bear cat].none?(/d/))
    end
  end
  
  context '#my_count' do
    it 'returns array length when no block given' do
      expect([1, 2, 3, 4].my_count).to eq 4
    end

    it 'returns number of items in array when item is an argument' do 
      expect([1, 2, 4, 2].my_count(2)).to eq 2
    end

    it 'returns number of items matching when given a block condition' do
      expect([1, 2, 4, 2].my_count(&:even?)).to eq 3
    end    

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect([1, 2, 3, 4].my_count).to eq([1, 2, 3, 4].count)
      expect([1, 2, 4, 2].my_count(2)).to eq([1, 2, 4, 2].count(2))
      expect([1, 2, 4, 2].my_count(&:even?)).to eq([1, 2, 4, 2].count(&:even?))
    end
  end

  context '#my_map' do
    it 'returns a modified array resulting from block operation' do
      expect([1, 2, 3, 4].my_map { |i| i * i }).to eq [1, 4, 9, 16]
    end

    it 'returns modified array when given a range with a block' do
      expect((1..4).my_map { |i| i * i }).to eq [1, 4, 9, 16]
    end

    it 'returns array of strings when given array of integers' do
      expect([1, 2].my_map(&:to_s)).to eq ['1', '2']
    end

    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect([1, 2].my_map(&:to_s)).to eq([1, 2].map(&:to_s))
      expect((1..4).my_map { |i| i * i }).to eq((1..4).map { |i| i * i })
      expect([1, 2, 3, 4].my_map { |i| i * i }).to eq([1, 2, 3, 4].map { |i| i * i })
    end
  end

  context '#my_inject' do
    it 'returns the accumulative result when given a starting value and a block operation' do
      expect((1..3).my_inject(1) { |product, n| product * n }).to eq 6
      expect([1, 2, 3, 4, 5].my_inject {|acc, val| acc + val}).to eq 15
    end

    it 'returns the accumulative result when given starting value and a urnary operator' do
      expect((5..10).my_inject(1, :*)).to eq 151200
    end

    it 'returns result when given a block condition against a neighboring item' do
      expect(%w{ cat sheep bear }.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eq 'sheep'
    end
    
    it 'all above-mentioned tests match the official enumerable method counterpart' do
      expect((1..3).my_inject(1) { |product, n| product * n }).to eq((1..3).inject(1) { |product, n| product * n })
      expect([1, 2, 3, 4, 5].my_inject {|acc, val| acc + val}).to eq([1, 2, 3, 4, 5].inject {|acc, val| acc + val})
      expect((5..10).my_inject(1, :*)).to eq((5..10).inject(1, :*))
      expect(%w{ cat sheep bear }.my_inject { |memo, word| memo.length > word.length ? memo : word }).to eq(%w{ cat sheep bear }.inject { |memo, word| memo.length > word.length ? memo : word })
    end

  end

  context '#multiply_els' do
    it 'returns result of function that uses #my_inject to multiply all items' do
      expect([2, 4, 5].multiply_els).to eq 40
    end
  end
end
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
end
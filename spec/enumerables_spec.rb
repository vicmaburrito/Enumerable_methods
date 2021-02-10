require_relative '../enumerable_methods'

enum = Enumerable

describe Enumerable do
  describe 'my_each' do
    it 'returns to_enum if no arguments or block were given' do
      expect([1, 2, 3].my_each).to be_a Enumerator
    end

    it 'returns the array when a block is given' do
      expect([1, 2, 3].my_each { |ele| }).to eql([1, 2, 3])
    end
  end

  describe 'my_each_with_index' do
    it 'returns to_enum if no arguments or block were given' do
      expect([1, 2, 3].my_each_with_index).to be_a Enumerator
    end

    it 'returns an array with its index if block were given' do
      expect([1, 2, 3].my_each_with_index { |ele, idx| }).to eql([1, 2, 3])
    end
  end

  describe 'my_select' do
    it 'returns an array containing all elements of enum for which the given block returns a true value.' do
      expect([1, 2, 3, 4, 8].my_select(&:even?)).to eql([2, 4, 8])
    end

    it 'If no block is given, an Enumerator is returned instead' do
      expect([1, 2, 3, 4].my_select).to be_a Enumerator
    end
  end

  describe 'my_all?' do
    it 'returns true if the block never returns false' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'returns false if all elements does not contain a Regexp pattern' do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it 'returns true if all elements are of the same class' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end

    it 'returns false if no block given and arg is equal to nil' do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it 'returns true if no block is given an the array is empty' do
      expect([].my_all?).to eql(true)
    end
  end

  describe 'my_any' do
    it 'returns true if the block ever returns a value other than false or nil' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
    end

    it 'returns false if any elements does not contain a Regexp pattern' do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
    end

    it 'returns true if any elements are of the same class' do
      expect([nil, true, 99].my_any?(Integer)).to eql(true)
    end

    it 'returns true if no block given and arg is equal to nil' do
      expect([nil, true, 99].my_any?).to eql(true)
    end

    it 'returns false if no block is given an the array is empty' do
      expect([].my_any?).to eql(false)
    end
  end

  describe 'my_none' do
    it 'returns true if the block never returns true for all elements' do
      expect(%w[ant bear cat].my_none? { |word| word.length == 5 }).to eql(true)
    end

    it 'returns true if the Regex pattern never matches with the elements' do
      expect(%w[ant bear cat].my_none?(/d/)).to eql(true)
    end

    it 'returns false if atleast one of the element is of the same Class' do
      expect([1, 3.14, 42].my_none?(Float)).to eql(false)
    end

    it 'returns true if the array is empty' do
      expect([].my_none?).to eql(true)
    end

    it 'returns true if arg is equal to nill' do
      expect([nil].my_none?).to eql(true)
    end
  end

  describe 'my_count' do
    it 'returns the number of items in enum through enumeration' do
      expect([1, 2, 3, 4].my_count).to eql(4)
    end

    it 'returns the number of items in enum that are equal to item are counted if an argument is given' do
      expect([1, 2, 3, 2].my_count(2)).to eql(2)
    end

    it 'counts the number of elements yielding a true value if a block is given' do
      expect([1, 2, 3, 2].my_count(&:even?)).to eql(2)
    end
  end

  describe 'my_map' do
    it 'returns a new array with the results of running block once for every element in enum' do
      expect((1..4).my_map { |i| i * i }).to eql([1, 4, 9, 16])
    end

    it 'returns an enumerator if no block is given' do
      expect((1..4).my_map { 'cat' }).to eql(%w[cat cat cat cat])
    end
  end

  describe 'my_inject' do
    it 'returns the sum total of range of numbers' do
      expect((5..10).my_inject(:+)).to eql(45)
    end

    it 'returns the sum total of range of numbers if block is given' do
      expect((5..10).my_inject { |total, value| total += value }).to eql(45)
    end

    it 'returns the multiplication total of range of numbers' do
      expect((5..10).my_inject(:*)).to eql(151_200)
    end

    it 'returns the multiplication total of range of numbers if block is given' do
      expect((5..10).my_inject { |total, value| total *= value }).to eql(151_200)
    end
  end
end

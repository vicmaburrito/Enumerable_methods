require_relative '../enumerable_methods'

enum = Enumerable

describe Enumerable do
  describe 'my_each' do 
    it 'returns to_enum if no arguments or block were given' do
      expect([1,2,3].my_each).to be_a Enumerator
    end

    it 'returns the array when a block is given' do
      expect([1,2,3].my_each {|ele|}).to eql([1,2,3])
    end
  end

  describe 'my_each_with_index' do
    it 'returns to_enum if no arguments or block were given' do
      expect([1,2,3].my_each_with_index).to be_a Enumerator
    end

    it 'returns an array with its index if block were given' do
      expect([1,2,3].my_each_with_index {|ele, idx|}).to eql([1,2,3])
    end
  end

  describe 'my_select' do
    it 'returns an array containing all elements of enum for which the given block returns a true value.' do
      expect([1,2,3,4,8].my_select {|p| p%2 == 0}).to eql([2,4,8])
    end

    it 'If no block is given, an Enumerator is returned instead' do
      expect([1,2,3,4].my_select).to be_a Enumerator
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






end
require './enumerable_methods'

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
end

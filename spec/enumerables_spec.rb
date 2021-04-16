require './enumerable_methods'

describe Enumerable do
  let(:friends) { %w[Sharon Leo Leila Brian Arun Jean] }
  let(:array_of_strings) { %w[ant bear cat] }
  let(:eg_range) { (1..15) }
  let(:numbers) { [5, 9, 2, 3, 415, 6, 98] }
  let(:ary) { [1, 2, 4, 2] }

  describe 'my_each' do
    it 'returns to_enum if no arguments or block were given' do
      expect([1, 2, 3].my_each).to be_a Enumerator
    end
    it 'returns the array when a block is given' do
      arr = []
      [1, 2, 3].my_each { |ele| arr.push(ele) }
      expect(arr).to eql([1, 2, 3])
    end
  end

  describe 'my_each_with_index' do
    it 'returns to_enum if no arguments or block were given' do
      expect([1, 2, 3].my_each_with_index).to be_a Enumerator
    end
    it 'returns an array with its index if block were given' do
      expect([1, 2, 3].my_each_with_index { |ele, idx| puts "#{ele} #{idx}" }).to eql([1, 2, 3])
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
    it 'when object is an array' do
      output = array_of_strings.my_all? { |word| word.length >= 4 }
      expect(output).to eql(false)
    end
    it 'when object is not an array' do
      output = eg_range.my_all? { |x| x > 0 }
      expect(output).to eql(true)
    end
    it 'when a block is given and arguments class is not regexp' do
      output = [1, 2i, 3.14].my_all?(Numeric)
      expect(output).to eql(true)
    end
    it 'when a block is given and arguments class is regexp' do
      output = %w[ant bear cat].my_all?(/t/)
      expect(output).to eql(false)
    end
    it 'when no block given, no arguments given and object is an empty array' do
      output = [].my_all?
      expect(output).to eql(true)
    end
    it 'when no block given and no arguments given' do
      output = [nil, true, 99].my_all?
      expect(output).to eql(false)
    end
  end

  describe 'my_any?' do
    it 'when object is an array' do
      output = array_of_strings.my_any? { |word| word.length >= 4 }
      expect(output).to eql(true)
    end
    it 'when object is not an array' do
      output = eg_range.my_any? { |x| x > 0 }
      expect(output).to eql(true)
    end
    it 'when a block is given and arguments class is not regexp' do
      output = [1, 2i, 3.14].my_any?(Integer)
      expect(output).to eql(true)
    end
    it 'when a block is given and arguments class is regexp' do
      output = %w[ant bear cat].my_any?(/d/)
      expect(output).to eql(false)
    end
    it 'when no block given, no arguments given and object is an empty array' do
      output = [].my_any?
      expect(output).to eql(false)
    end
    it 'when no block given and no arguments given' do
      output = [nil, true, 99].my_any?
      expect(output).to eql(true)
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
    it 'no block given' do
      expect(ary.my_count).to eql(4)
    end
    it 'block given and arguments not nil' do
      expect(ary.my_count(2)).to eql(2)
    end
    it 'block given and arguments not nil' do
      expect(ary.my_count(&:even?)).to eql(3)
    end
  end

  describe 'my_map' do
    it 'when no block and no proc is given it returns Enumerable' do
      expect(eg_range.my_map).to be_an(friends.to_enum.class)
    end
    it 'when block is given and no proc argument' do
      output = (1..4).my_map do |item|
        item * item
      end
      expect(output).to eql([1, 4, 9, 16])
    end
    it 'when no block is given and a proc is an argument' do
      test_proc = proc { |item| item * item }
      output = (1..4).my_map(&test_proc)
      expect(output).to eql([1, 4, 9, 16])
    end
  end

  describe 'my_inject' do
    it 'only one argument and argument is a symbol' do
      output = numbers.my_inject(:+)
      expect(output).to eql([5, 9, 2, 3, 415, 6, 98].inject(:+))
    end
    it 'object is not an array but a Range, arg is a symbol' do
      output = (5..10).my_inject(:+)
      expect(output).to eql((5..10).inject(:+))
    end
    it 'method has a block and no arguments' do
      output = (5..10).my_inject { |sum, n| sum + n }
      expected = (5..10).inject { |sum, n| sum + n }
      expect(output).to eql(expected)
    end
    it 'method has a block and an argument' do
      output = (5..10).my_inject(1) { |product, n| product * n }
      expected = (5..10).inject(1) { |product, n| product * n }
      expect(output).to eql(expected)
    end
    it 'method has two arguments' do
      output = (5..10).my_inject(1, :*)
      expected = (5..10).inject(1, :*)
      expect(output).to eql(expected)
    end
  end
end

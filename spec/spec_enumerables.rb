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

  describe 'my_select' do
    it 'returns an array containing all elements of enum for which the given block returns a true value.' do
      expect([1, 2, 3, 4, 8].my_select(&:even?)).to eql([2, 4, 8])
    end
    it 'If no block is given, an Enumerator is returned instead' do
      expect([1, 2, 3, 4].my_select).to be_a Enumerator
    end
  end

  let(:array_of_strings) { %w[ant bear cat] }
  let(:eg_range) { (1..15) }
  describe '#my_all?' do
    context 'when object is an array' do
      it '#my_all?' do
        output = array_of_strings.my_all? { |word| word.length >= 4 }
        expect(output).to eql(false)
      end
    end
    context 'when object is not an array' do
      it '#my_all?' do
        output = eg_range.my_all? { |x| x > 0 }
        expect(output).to eql(true)
      end
    end
    context 'when a block is given and arguments class is not regexp' do
      it '#my_all?' do
        output = [1, 2i, 3.14].my_all?(Numeric)
        expect(output).to eql(true)
      end
    end
    context 'when a block is given and arguments class is regexp' do
      it '#my_all?' do
        output = %w[ant bear cat].my_all?(/t/)
        expect(output).to eql(false)
      end
    end
    context 'when no block given, no arguments given and object is an empty array' do
      it '#my_all?' do
        output = [].my_all?
        expect(output).to eql(true)
      end
    end
    context 'when no block given and no arguments given' do
      it '#my_all?' do
        output = [nil, true, 99].my_all?
        expect(output).to eql(false)
      end
    end
  end

  describe '#my_any?' do
    context 'when object is an array' do
      it '#my_any?' do
        output = array_of_strings.my_any? { |word| word.length >= 4 }
        expect(output).to eql(true)
      end
    end
    context 'when object is not an array' do
      it '#my_any?' do
        output = eg_range.my_any? { |x| x > 0 }
        expect(output).to eql(true)
      end
    end
    context 'when a block is given and arguments class is not regexp' do
      it '#my_any?' do
        output = [1, 2i, 3.14].my_any?(Integer)
        expect(output).to eql(true)
      end
    end
    context 'when a block is given and arguments class is regexp' do
      it '#my_any?' do
        output = %w[ant bear cat].my_any?(/d/)
        expect(output).to eql(false)
      end
    end
    context 'when no block given, no arguments given and object is an empty array' do
      it '#my_any?' do
        output = [].my_any?
        expect(output).to eql(false)
      end
    end
    context 'when no block given and no arguments given' do
      it '#my_any?' do
        output = [nil, true, 99].my_any?
        expect(output).to eql(true)
      end
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

  describe '#my_count' do
    let(:ary) { [1, 2, 4, 2] }
    context 'no block given' do
      it '#my_count' do
        expect(ary.my_count).to eql(4)
      end
    end
    context 'block given and arguments not nil' do
      it '#my_count' do
        expect(ary.my_count(2)).to eql(2)
      end
      it '#my_count' do
        expect(ary.my_count(&:even?)).to eql(3)
      end
    end
  end

  describe '#my_map' do
    context 'when no block and no proc is given it returns Enumerable' do
      it '#my_map' do
        expect(eg_range.my_map).to be_an(friends.to_enum.class)
      end
    end
    context 'when block is given and no proc argument' do
      it '#my_map' do
        output = (1..4).my_map do |item|
          item * item
        end
        expect(output).to eql([1, 4, 9, 16])
      end
    end
    context 'when no block is given and a proc is an argument' do
      it '#my_map' do
        test_proc = proc { |item| item * item }
        output = (1..4).my_map(&test_proc)
        expect(output).to eql([1, 4, 9, 16])
      end
    end
  end
end

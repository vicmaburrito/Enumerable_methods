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
end

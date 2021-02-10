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









end
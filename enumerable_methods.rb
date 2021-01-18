module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    counter = 0
    while counter < size
      yield(self[counter])
      counter += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i < size
      yield to_a[i], i
      i += 1
    end
    self
  end
end

def my_select
  return to_enum(:my_select) unless block_given?

  result = []
  counter = 0
  to_a.my_each do |index|
    if yield index
      result[counter] = index
      counter += 1
    end
  end
  result
end

# def my_select
#  return to_enum(:my_select) unless block_given?

#  mutated_arr = []
#  counter = 0
#   while counter < self.size
#    mutated_arr << (self[counter]) if yield(self[counter]) == true
#     counter += 1
#   end
#    mutated_arr
# end

names = []
e.my_each { |name| names.push(name) }

p [1, 2, 3].my_each { |i| p i + 2 }
p [1, 2, 3].my_each_with_index { |counter, v| p "this is #{counter} of #{v}" }
p [1, 2, 3].my_select

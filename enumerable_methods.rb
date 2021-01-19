module Enumerable
  # my each
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = is_a?(Enumerable) && !is_a?(Array)? to_a : self
    counter = 0
    while counter < size 
      yield (arr[counter])
      counter += 1
    end
    self
  end
  #my_each_with_index
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = is_a?(Enumerable) && !is_a?(Array)? to_a : self
    counter = 0
    while counter < size 
      yield(arr[counter], counter)
      counter += 1
    end
    self
  end

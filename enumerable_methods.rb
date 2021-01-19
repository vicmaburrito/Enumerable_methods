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
  #my_select
  def my_select
   return to_enum(:my_select) unless block_given?
    result = []

    my_each { |i| result << i if yield(i) }
    result
 end
 #my_all
 def my_all?
  if block_given?

   my_each {|result| return false unless yield result}
  else
   my_each {|result| return false unless result }
  end
    true
 end
 #my_any?
 def my_any?
  if block_given?

   my_each {|result| return false unless yield result}
  else
   my_each {|result| return false unless result }
  end
   true
 end

end
p %w[ant bear cat].my_any? { |word| word.length >= 3 }
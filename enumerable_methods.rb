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

   my_each {|result| return true unless yield result}
  else
   my_each {|result| return true unless result }
  end
   false
 end
 #my_none
 def my_none?
  if block_given?

   my_each {|result| return false unless yield result}
  else
   my_each {|result| return false unless result }
  end
   true
 end
 #my_count
 def my_count
  if block_given?
   count = 0
   my_each { |i| count += 1 if yield(i) }
 end

end
end
 %w[1 2 3 4].my_count { |word|p word.length >= 3 }
module Enumerable

  def my_each
    return to_enum(:my_each) unless block_given?

    arr = is_a?(Enumerable) && !is_a?(Array) ? to_a : self
    counter = 0
    while counter < size
      yield (arr[counter])
      counter += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = is_a?(Enumerable) && !is_a?(Array) ? to_a : self
    counter = 0
    while counter < size
      yield(arr[counter], counter)
      counter += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    result = []
    my_each { |i| result << i if yield(i) }
    result
  end

  def my_all?(*arg)
    return grep(arg.first).length == size unless arg.empty?

    my_each { |result| return false unless yield(result) } if block_given?
    my_each { |result| return false unless result } unless block_given?
    true
  end

  def my_any?(*arg)
    return !grep(arg.first).empty? unless arg.empty?

    my_each { |result| return true if yield(result) } if block_given?
    my_each { |result| return true if result } unless block_given?
    false
  end

  def my_none?(*arg)
    return grep(arg.first).empty? unless arg.empty?

    my_each { |result| return false if yield(result) } if block_given?
    my_each { |result| return false if result } unless block_given?
    true
  end

  def my_count(*arg, &block)
    return my_select { |result| result == arg.first }.length unless arg.empty?
    return my_select(&block).length if block_given?

    size
  end

  def my_map(par_ = nil)
    new_arr = []
    return to_enum unless block_given?

    if par_
      my_each { |i| new_arr << par_.call(i) }
    else
      my_each { |i| new_arr << yield(i) }
    end
    new_arr
  end

  def my_inject(*arg)
    res = nil
    if arg.first && [Integer, Float].include?(arg.first.class)
      res = arg.first
      arr = to_a
    else
      res = first
      arr = to_a[1..-1]
    end
    if block_given?
      arr.my_each { |el| res = yield(res, el) }
    elsif arg.last.is_a? Symbol
      arr.my_each { |el| res = arg.last.to_proc.call(res, el) }
    else
      res = to_enum
    end
    res
  end

  def multiply_els(arr)
    arr.inject { |total, n| total * n }
  end
end
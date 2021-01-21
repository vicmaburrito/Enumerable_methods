module Enumerable
  # my each
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

  # my_each_with_index
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

  # my_select
  def my_select
    return to_enum(:my_select) unless block_given?

    result = []

    my_each { |i| result << i if yield(i) }
    result
  end

  # my_all
  def my_all?(arg = nil)
    if block_given?
      my_each { |result| return false unless yield result }
    elsif arg.is_a? Regexp
      my_each { |result| return false if result.to_s =~ arg }
    elsif arg.is_a? Class
      my_each { |result| return false if result.is_a? arg }
    else
      my_each { |result| return false unless result }
    end
    true
  end

  # my_any?
  def my_any?(arg = nil)
    if block_given?
      my_each { |result| return true unless yield result }
    elsif arg.is_a? Regexp
      my_each { |result| return true if result.to_s =~ arg }
    elsif arg.is_a? Class
      my_each { |result| return true if result.is_a? arg }
    else
      my_each { |result| return true unless result }
    end
    false
  end

  # my_none
  def my_none?(arg = nil)
    if block_given?
      my_each { |result| return false unless yield result }
    elsif arg.is_a? Regexp
      my_each { |result| return false if result.to_s =~ arg }
    elsif arg.is_a? Class
      my_each { |result| return false if result.is_a? arg }
    else
      my_each { |result| return false unless result }
    end
    true
  end

  # my_count
  def my_count
    return to_enum(:my_count) unless block_given?

    count = 0
    my_each do |i|
      count += 1
      yield(i)
    end
  end

  # my_map
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

  # my_inject
  def my_inject(*args)
    if args[0].is_a? Integer
      accumulator = args[0]
      symbol = args[1]
    else
      symbol = args[0]
    end
    if block_given? && args.size == 1
      my_each { |x| accumulator = yield(accumulator, x) }
    elsif args.size == 2
      my_each { |x| accumulator = accumulator.send(symbol, x) }
    elsif block_given?
      my_each { |x| accumulator = accumulator ? yield(accumulator, x) : x }
    elsif block_given? == false
      my_each { |x| accumulator = accumulator ? yield(accumulator, x) : x }
    else
      my_each { |x| accumulator = accumulator ? accumulator.send(symbol, x) : x }
    end
    accumulator
  end

public

def multiply_els
  my_inject(1, :*)
end
end

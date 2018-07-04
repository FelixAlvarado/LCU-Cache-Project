require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    hash = num.hash
    @store[hash % @store.length].push(num)
    @count += 1
    resize! if @count == @store.length
  end

  def include?(num)
    hash = num.hash
    @store[hash % @store.length].include?(num)
  end

  def remove(num)
    hash = num.hash
    @store[hash % @store.length].delete(num)
    @count -= 1
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    items = []
    new_array = Array.new(@store.length * 2) { Array.new }
    @store.each do |el|
      el.each do |el2|
        items.push(el2) if el2 != nil
      end 
    end 
    items.each do |el|
      new_array[el % (@store.length * 2)].push(el)
    end 
    @store = new_array
  end
end

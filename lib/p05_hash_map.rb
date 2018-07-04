require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    @store[key.hash % @store.length].include?(key)
  end

  def set(key, val)
    list = @store[key.hash % @store.length]
     if list.include?(key)
        list.remove(key) 
         @count -= 1 
     end 
    list.append(key,val)
    @count += 1
    resize! if @count >= @store.length
  end

  def get(key)
    @store[key.hash % @store.length].get(key)
  end

  def delete(key)
    @store[key.hash % @store.length].remove(key)
    @count -= 1
  end

  def each
    @store.each do |list|
      list.each {|el| yield [el.key, el.val]}
    end 
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    items = []
    new_array = Array.new(@store.length * 2) {LinkedList.new}
    each {|node| items.push(node)}
    p items
    items.each do |node|
      new_array[node[0].hash % (@store.length * 2)].append(node[0], node[1])
    end 
    @store = new_array
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end

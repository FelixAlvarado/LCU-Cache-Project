class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @next.prev = @prev 
    @prev.next = @next
  end
end

class LinkedList
  include Enumerable
  def initialize
    @head = Node.new 
    @tail = Node.new 
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_node = first 
    while current_node != @tail
      if current_node.key == key
        return current_node.val
      end 
      current_node = current_node.next
    end 
  end

  def include?(key)
    current_node = first 
    while current_node != @tail
      if current_node.key == key
        return true
      end 
      current_node = current_node.next
    end 
    false
  end

  def append(key, val)
    new_node = Node.new(key,val)
    last.next, new_node.prev = new_node, last 
    @tail.prev, new_node.next = new_node, @tail
   end

  def update(key, val)
    current_node = first 
    while current_node != @tail
      if current_node.key == key
        current_node.val = val
      end 
      current_node = current_node.next
    end 
  end

  def remove(key)
    current_node = first 
    while current_node != @tail
      if current_node.key == key
        current_node.remove
      end 
      current_node = current_node.next
    end 
  end

  def each
    current_node = first 
    while current_node != @tail
      yield current_node
      current_node = current_node.next
    end 
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end

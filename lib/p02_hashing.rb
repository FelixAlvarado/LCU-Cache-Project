class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
   result = self.length.to_s 
   self.each {|el| result += el.to_s}
   result.to_i
  end
end

class String
  def hash
    result = ''
    self.chars.each do |letter|
      result += letter.ord.to_s
    end 
    result.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    new_hash = self.sort_by{|k,v| k.to_s}
    result = []
    new_hash.each {|el| result.push(el[0].to_s.ord.to_s)}
    new_hash.each {|el| result.push(el[1].to_s.ord.to_s)}
    result.join('').to_i
  end
end

#!/usr/bin/env ruby
# http://pascalbetz.github.io/ruby/2016/03/14/lookup-path/

module Include
  def call(level)
    puts "#{level} include"
    super(level + 1) rescue nil
  end
end

module Prepend
  def call(level)
    puts "#{level} prepend"
    super(level + 1) rescue nil
  end
end

module Extend
  def call(level)
    puts "#{level} extend"
    super(level + 1) rescue nil
  end
end

class Super
  def call(level)
    puts "#{level} super"
    super(level + 1) rescue nil
  end
end

class Klass < Super
  include Include
  prepend Prepend


  def call(level)
    puts "#{level} klass"
    super(level + 1) rescue nil
  end

end

thing = Klass.new

def thing.call(level)
  puts "#{level} singleton"
  super(level + 1) rescue nil
end

thing.extend(Extend)

thing.call(1)

p thing.class.ancestors
p thing.singleton_class.ancestors

p Klass.new.singleton_class
p Klass.new.singleton_class
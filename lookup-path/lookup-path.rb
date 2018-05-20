#!/usr/bin/env ruby
# http://pascalbetz.github.io/ruby/2016/03/14/lookup-path/

module Include
  def self.call(level) # never called
    puts "#{level} Include Singleton class"
    super(level + 1) rescue nil
  end

  def call(level)
    puts "#{level} include"
    super(level + 1) rescue nil
  end
end

module Prepend
  def self.call(level) # never called
    puts "#{level} Prepend Singleton class"
    super(level + 1) rescue nil
  end

  def call(level)
    puts "#{level} prepend"
    super(level + 1) rescue nil
  end
end

module Extend
  def self.call(level) # never called
    puts "#{level} Extend Singleton class"
    super(level + 1) rescue nil
  end

  def call(level)
    puts "#{level} extend"
    super(level + 1) rescue nil
  end
end

class Super
  def self.call(level)
    puts "#{level} Super Singleton class"
    super(level + 1) rescue nil
  end

  def call(level)
    puts "#{level} super"
    super(level + 1) rescue nil
  end
end

class Klass < Super
  include Include
  prepend Prepend
  extend Extend # add only `def call` to singleton class
  def self.call(level)
    puts "#{level} Klass Singleton class"
    super(level + 1) rescue nil
  end

  def call(level)
    puts "#{level} klass"
    super(level + 1) rescue nil
  end
end

thing = Klass.new

def thing.call(level)
  puts "#{level} Object singleton"
  super(level + 1) rescue nil
end

thing.extend(Extend)

thing.call(1)
# 1 singleton
# 2 extend
# 3 prepend
# 4 klass
# 5 include
# 6 super

Klass.call(1)
# 1 Klass Singleton class
# 2 extend
# 3 Super Singleton class

p thing.class.ancestors
# [Prepend, Klass, Include, Super, Object, Kernel, BasicObject]
p thing.singleton_class.ancestors
# [#<Class:#<Klass:0x000000020ed2b8>>, Extend, Prepend, Klass, Include, Super, Object, Kernel, BasicObject]

p Klass.new.singleton_class
p Klass.new.singleton_class
# #<Class:#<Klass:0x000000020ec020>>
# #<Class:#<Klass:0x000000020e3f10>>

#!/usr/bin/env ruby

module Profiler
  def self.prepended(base)
    (base.instance_methods(false) + ['initialize']).each do |name|
      Profiler.send :define_method, name do |*params|
        start = Time.now
        result = super *params
        duration = Time.now - start
        puts "[Profiler] (#{name}) execution time: #{duration.to_i} seconds"
        result
      end
    end
 end

end


class TestClass
  def initialize(str)
    puts str
    sleep 1
    foo1 'text for foo1'
  end

  def foo1(str)
    sleep 1
    puts str
  end

  def foo2(str, count)
    sleep 1
    puts str * count
  end

  prepend Profiler
end

test = TestClass.new 'initialize'
test.foo2 'foo2', 3
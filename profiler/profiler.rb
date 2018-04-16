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
    puts "initialize: #{str}"
    sleep 1
    foo1 'text for foo1'
  end

  def foo1(str)
    sleep 1
    puts "foo1: #{str}"
  end

  def foo2(str, count)
    sleep 1
    puts "foo2: #{str}, #{count}"
  end

  # prepend Profiler # Variant #1
end

# test = TestClass.new 'hello'
test = TestClass.prepend(Profiler).new 'hello' # Variant #2

# test.class.prepend Profiler # Variant #3
test.foo2 'text for foo2', 3

# initialize: hello
# foo1: text for foo1
# [Profiler] (foo1) execution time: 1 seconds
# [Profiler] (initialize) execution time: 2 seconds
# foo2: text for foo2, 3
# [Profiler] (foo2) execution time: 1 seconds
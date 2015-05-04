# Design pattern: Iterator
# Description: allow sequential access to elements of an aggregate object without exposing details of underyling representation
#
# There are two types of iterators in Ruby:
# 1. iternal iterator - is defined and manipulated internally e.g. #each on array collection
# 2. external iterator - it can be passed around for other objects to use it, you are in control of iteration

class Leaf
  def initialize(item)
    @item = item
  end

  def value
    @item
  end
end

class ExprNode
  def initialize(left, operator, right)
    @left = left
    @operator = operator
    @right = right
    # store current state for partial evaluation of expression
    @iterator = each
    @stack = []
  end

  # postfix notation
  def value
    [*@left.value, *@right.value, @operator]
  end

  # 1. uses internal defined on array
  def each(&block)
    value.each(&block)
  end

  # 2. external iterator for partial evaluation
  def partial_eval
    item = nil
    loop do
      item = @iterator.next
      break unless item
      @stack << item
      if ['+', '-', '*', '/'].include?(item.to_s)
        left, right, op = @stack.pop(3)
        result = left.send(op, right)
        @stack << result
        return result
      end
    end
  end

  # there could other methods e.g. for reseting iterator, full evaluation, ...
end

expr1 = ExprNode.new(Leaf.new(5), :*, Leaf.new(6))
expr2 = ExprNode.new(Leaf.new(9.0), :/, Leaf.new(4))
expr = ExprNode.new(expr1, :+, expr2)
expr.each {|i| print "#{i} " }
# => 5 6 * 9.0 4 / +
puts

puts expr.partial_eval
# => 30
puts expr.partial_eval
# => 2.25
puts expr.partial_eval
# => 32.25

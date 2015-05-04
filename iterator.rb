class ListNode
  def initialize(item)
    @item = item
  end

  def value
    @item
  end
end

class TreeNode
  def initialize(left, operator, right)
    @left = left
    @operator = operator
    @right = right
    @stack = []
    @iterator = each
  end

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

  def each(&block)
    value.each(&block)
  end

  def value
    [*@left.value, *@right.value, @operator]
  end
end

expr1 = TreeNode.new(ListNode.new(5), :*, ListNode.new(6))
expr2 = TreeNode.new(ListNode.new(9.0), :/, ListNode.new(4))
expr = TreeNode.new(expr1, :+, expr2)
expr.each {|i| print "#{i} " }
puts
puts expr.partial_eval
puts expr.partial_eval
puts expr.partial_eval

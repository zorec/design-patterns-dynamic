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
  end

  def each(&block)
    value.each(&block)
  end

  def iterator_each(&block)
    iterator = each
    item = nil
    loop do
      yield item if item
      item = iterator.next
    end
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
expr.iterator_each {|i| print "#{i} " }
puts

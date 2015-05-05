# Design pattern: Decorator
# Description: Attach additional responsibilities to an object dynamically. Decorators provide a flexible alternative to subclassing for extending functionality.

require 'forwardable'

class Coffee
  def cost
    2
  end
end

class Milk
  extend Forwardable
  def_delegator :@base, :base_cost, :cost

  def initialize(base)
    @base = base
  end

  def cost
    base_cost + 0.4
  end
end

class Sugar
  extend Forwardable
  def_delegator :@base, :base_cost, :cost

  def initialize(base)
    @base = base
  end

  def cost
    base_cost + 0.1
  end
end


coffee = Coffee.new
sugar_coffe = Sugar.new(coffee)
puts sugar_coffe.cost
# => 2.1
milk_coffe = Milk.new(coffee)
puts milk_coffe.cost
# => 2.4

# re-implementation of typical example  e.g https://robots.thoughtbot.com/evaluating-alternative-decorator-implementations-in
# class Coffee
#   def cost
#     2
#   end
# end
#
# module Milk
#   def cost
#     super + 0.4
#   end
# end
#
# module Sugar
#   def cost
#     super + 0.2
#   end
# end
#
# coffee = Coffee.new
# coffee.extend(Milk)
# coffee.extend(Sugar)
# coffee.cost   # 2.6

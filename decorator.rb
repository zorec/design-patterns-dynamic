# Design pattern: Decorator
# Description: Attach additional responsibilities to an object dynamically.
# Decorators provide a flexible alternative to subclassing for extending functionality.

# use SimpleDelegator
require 'delegate'

class Coffee
  def cost
    2
  end
end

class Milk < SimpleDelegator
  def cost
    get_base.cost + 0.4
  end

  alias get_base __getobj__
end

class Sugar < SimpleDelegator
  def cost
    get_base.cost + 0.1
  end

  alias get_base __getobj__
end


coffee = Coffee.new
sugar_coffe = Sugar.new(coffee)
puts sugar_coffe.cost
# => 2.1
milk_coffee = Milk.new(coffee)
puts milk_coffee.cost
# => 2.4
double_milk = Milk.new(milk_coffee)
puts double_milk.cost
# => 2.8

# inspired by https://robots.thoughtbot.com/evaluating-alternative-decorator-implementations-in
<<-EXAMPLE
class Coffee
  def cost
    2
  end
end

module Milk
  def cost
    super + 0.4
  end
end

module Sugar
  def cost
    super + 0.2
  end
end

coffee = Coffee.new
coffee.extend(Milk)
coffee.extend(Sugar)
coffee.cost   # 2.6
EXAMPLE

# Design pattern: Factory
# Description: Define an interface for creating an object, but let subclasses decide which class to instantiate.
# Factorymethod lets a class defer instantiation to subclasses.
# Full credits: Neal Ford, ThoughtWorks http://assets.en.oreilly.com/1/event/27/%22Design%20Patterns%22%20in%20Dynamic%20Languages%20Presentation.pdf

class Factory
  def self.create_from(factory)
    factory.new
  end
end

array = Factory.create_from(Array)
array << 12
puts array
# => 12

# Design pattern: interpreter
# Description: Given a language, define a representation for its grammar along
# with an interpreter that uses the representation to interpret sentences in the language.

# Ruby allows easy creation of DSL without overhead of building interpreter
# Example of implementing test specification syntax (Rspec) see below

class Object
  def describe(description, &block)
    block.call
  end
  alias it describe

  def expect(obj)
    Expectation.new(obj)
  end

  def be(bool)
    [:===, bool]
  end

  def equal(value)
    [:==, value]
  end

  # greater_or_equal_thand
end

class Expectation
  def initialize(obj)
    @obj = obj
  end

  def to(array)
    method, value = array
    method_description = {:== => "be equal", :=== => "be"}[method]
    result = @obj.send(method, value) ? "OK" : "Failed"
    puts "Expected #{@obj} to #{method_description} #{value} - #{result}!"
  end
end

describe "test specification" do
  it "passes!" do
    expect(true).to be true
    # => Expected true to be true - OK!
  end

  it "fails!" do
    expect(1).to equal 2
    # => Expected 1 to be equal 2 - Failed!
  end
end

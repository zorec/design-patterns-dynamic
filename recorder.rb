# Design pattern: recorder, the ultimate decorator pattern
# Description: record actions to allow playback
# Full credits: Neal Ford, ThoughtWorks http://assets.en.oreilly.com/1/event/27/%22Design%20Patterns%22%20in%20Dynamic%20Languages%20Presentation.pdf

# BasicObject is an empty object without any methods
class Recorder < BasicObject
  def initialize
    @messages = []
  end

  def method_missing(method, *args, &block)
    @messages << [method, args, block]
  end

  def playback_to_obj(obj)
    @messages.each do |method, args, block|
      obj.send(method, *args, &block)
    end
  end
end

recorder = Recorder.new
recorder.sub!(/Java/) { "Ruby" }
recorder.upcase!
recorder[11, 5] = "Universe"
recorder << "!"

s = "Hello Java world"
recorder.playback_to_obj(s)
puts s
# => HELLO RUBY Universe!

# Design pattern: Singleton
# Description: There should be only one instance of the class

class Screen
  @@instance = Screen.new

  # attr_reader on class variable
  class << self
    attr_reader :instance
  end

  private_class_method :new

  # prepare_window, switch_prepared_screen_window, ...
end

screen = Screen.instance
puts screen == Screen.instance
# => true
puts screen === Screen.instance
# => true

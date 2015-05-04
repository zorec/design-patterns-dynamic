# Design pattern: Command
# Description: pass encapsulated request with parameters to other object to execute it
#

class Army
  attr_accessor :x, :y, :soldiers_count

  def initialize(x, y, soldiers_count)
    @x = x
    @y = y
    @soldiers_count = soldiers_count
  end

  def execute(command)
    proc_command = command.command
    command.execute(self, &proc_command)
  end
end

class Command
  def execute(army, &proc)
    yield army
  end
end

class Move < Command
  def initialize(right, up)
    @right = right
    @up = up
  end

  def command
    @command ||= Proc.new do |a|
      puts "move #{@right} units to right and #{@up} units up"
      a.x += @right
      a.y += @up
    end
  end

  def undo_command
    Move.new(-@right, -@up)
  end
end

class Attack < Command
  def initialize(enemy)
    @enemy = enemy
  end

  def command
    Proc.new do |a|
      puts "battle"
      a.soldiers_count -= @enemy.soldiers_count
      a.soldiers_count = 0 if a.soldiers_count < 0
    end
  end

  def undo_command
    raise "Not undoable!"
  end
end

army = Army.new(0, 0, 100)
army.execute Move.new(5, 0)
move_down =  Move.new(-10, 1)
army.execute move_down
army.execute move_down.undo_command
enemy = Army.new(10, 15, 90)
army.execute Attack.new(enemy)

# output
%{
move 5 units to right and 0 units up
move -10 units to right and 1 units up
move 10 units to right and -1 units up
battle
}

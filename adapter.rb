# Design pattern: Adapter
# Description: adapt to the different interface

# we are trying to adopt to this interface which excepts object with to_grade_str method
class ExamResult
  def initialize(grade)
    @grade = grade
  end

  def verdict
    if @grade.to_grade_str == "F"
      "You shall not pass!"
    else
      "You passed! Congratulations!"
    end
  end

end

# we could create wrapper class
class Grade
  def initialize result
    @result = result
  end

  def to_grade_str
    case @result
      when 0..50 then "F"
      when 51..59 then "E"
      when 60..69 then "D"
      when 70..79 then "C"
      when 80..89 then "B"
      when 90..100 then "A"
      when "A".."F" then @result
      else raise "Unkown grade!"
    end
  end

  # e.g. to_points
end

# but we can also reopen Numeric and String classes
class String
  def to_grade_str
    raise "Unkown grade!" unless ("A".."F").to_a.include? self
    self
  end
end

class Numeric
  def to_grade_str
    Grade.new(self).to_grade_str
  end
end

# just to further illustrate problem of incompatible interfaces
class WrittenExam
  def result
    Grade.new(rand(0..100))
  end
end

class OralExam
  def result
    ("A".."F").to_a.sample
  end
end

math_grade = WrittenExam.new.result
puts ExamResult.new(math_grade).verdict
# results are random e.g.
# => You shall not pass!
english_grade = OralExam.new.result
# => You passed! Congratulations!
puts ExamResult.new(english_grade).verdict

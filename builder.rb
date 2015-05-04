# Design pattern: Builder
# Description: Simplify creation of objects by separating construction from representation

class HeroBuilder
  def method_missing(method)
    sex = "female"
    skills = []
    method.to_s.split("_").each do |name|
     next if ["with", "and"].include? name
     sex = name if ["male", "female"].include? name
     skills << name
    end
    Hero.new(skills, sex)
  end
end

class Hero
  attr_reader :skills

  def initialize(skills=[], sex="female")
    @skills = skills
    @sex = sex
  end
end

hero_builder = HeroBuilder.new
superwoman = hero_builder.emphaty_intelligence_and_goodwill
superman = hero_builder.male_with_strength_speed

puts superman.skills.join(" ")
# => male strength speed

puts superwoman.skills.join(" ")
# => emphaty intelligence goodwill

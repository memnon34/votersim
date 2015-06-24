require "./voter.rb"
include Voter

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.create
    puts "What would you like to create? Politician or Voter?"
    choice = prompt_and_get.downcase!
    if choice == ""
  end
end


class Politician
  attr_accessor :name, :party
end

class Voter
  attr_accessor :name, :view
end




def test
  john = Person.new("John Doe")
  p john
  Person.create
end

test


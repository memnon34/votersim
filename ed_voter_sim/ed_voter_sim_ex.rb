require 'minitest/autorun'

#need a place for players to act.
class World

  def initialize
    @politicians = []
    @voter = []
  end

  def create_politician(name)
    @politicians << Politician.new(name)
  end

  def list_politicians
    @politicians
  end

  def create_voter
    @politcians << Voter.new
  end

  def list_voter
    @voter
  end

  def update_politician(name, new_name, new_politics)
    politian = get_politician(name)
    poitician.name 
  end

  def get_politician(name)
    @politicians.select do |politician|
      politician.name == name
    end.first
  end

end

class Politician
  attr_accessor :name

  def initialize(name)
    @name = name
  end

end

class Voter
end

class VoterSimTest < Minitest::Test
   def test_world
    world = World.new

    world.create_politician("Ed")                   #you can also use assert_equal "arg", method_that_should_return_value
    assert world.list_politicians.length == 1 #with minitest, you use "assert," instead of puts,  and if it's false, it will raise an error.
    world.create_voter

  end

  def test_politician
    pol = Politician.new
  end

  def test_voter
    voter = Voter.new
  end

  def test_update_politician
    world = World.new

    name = "Ed"
    new_name = "Jon"
    new_politics = "Democrat"
    world.update_politician(name, new_name, new_politics)

    politician = world.get_politician(name)

  end

end
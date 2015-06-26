#edit the list function so it iterates over the arrays and returns name=>view for 
#voters, and name=>party for politicians. 
#create the default lists to populate the array in case players are lazy.
#start working on the campaign mechanic.
#Get to the voting mechanic. 
#remember TDD! It has helped a lot. 

require "./votersim.rb"
require 'minitest/autorun'
include Votersim

class World#the way I have this, do I need a world class? Keep for now.

  def initialize
  end

  def main_menu
    #put the game intro somewhere else. Keep this just for the menu options.
    # puts "Let's kick off the 2016 election! What would you like to do first?\n\n"
    puts "Choose from the following options: "
    puts "\t☞\tTo create a voter, press 1."
    puts "\t☞\tTo create a politician, press 2"
    puts "\t☞\tTo list all eligible voters, press 3"
    puts "\t☞\tTo list all the politicians, press 4"
    puts "\t☞\tTo send the politicians on the campaign trail, press 5"
    puts "\t☞\tTo start the election, press 6"
    puts "\n\t☞\tAt any time, press 7 to add a default list of voters and politicians."
    menu_selection(prompt_and_get)
  end

  def menu_selection(num)
    case num
    when "1"
      create_voter
    when "2"
      create_politician
    when "3"
      Voter.list_voters
    when "4"
      Politician.list_politicians
    when "5"
      #prompt for which politician is starting to campaign
      #launch_campaign(politicianname)
      #This should send to the launch campaign method, which I haven't written
    when "6"
      #this should start the election. 
    when "7"
      #this should populate the voter and politican arrays.
    else
      puts "I hope you're not trying to break my code...\n"
      puts "Please make a valid selection! Here's the menu again.\n\n"
      main_menu
    end
  end

  def create_voter
    puts "Voter name?"
    name = prompt_and_get.downcase rescue "mary"
    puts "Voter's political views?"
    puts "Choose from the following: "
    puts "\t☞\tLiberal\n\t☞\tConservative\n\t☞\tSocialist\n\t☞\tTea Party\n\t☞\tNeutral"
    view = prompt_and_get.downcase rescue "liberal"
    current_voter = Voter.new(name, view)
    puts "Success!"
    puts "You've created a new voter: #{capitalize_each_word(current_voter.name)}." 
    puts "This voter leans: #{capitalize_each_word(current_voter.view)}."
  end

  def create_politician
    puts "Politician name?"
    name = prompt_and_get.downcase rescue "barack obama"
    puts "Politician's political views?"
    puts "Choose from the following: "
    puts "\t☞\tLiberal\n\t☞\tConservative\n\t☞\tSocialist\n\t☞\tTea Party\n\t☞\tNeutral"
    view = prompt_and_get.downcase rescue "liberal"
    current_politician = Politician.new(name, view)
    puts "Success!"
    puts "You've created a new politician: #{capitalize_each_word(current_politician.name)}." 
    puts "This politician leans: #{capitalize_each_word(current_politician.view)}."
    puts "And his/her political party is: #{capitalize_each_word(current_politician.party)} "
  end

end


class Voter
  attr_accessor :name, :view, :voter_array
  @@voter_array = []
  
  def initialize(name, view)
    @name = name
    @view = view
    @@voter_array << self
  end

  def update_voter(name)
    @@voter_array.each do |voters| 
      if voters.name == name
        voters.name = "newname"
      else
        voters
      end
    end
  end

  def self.list_voters
    @@voter_array
  end

end

class Politician < Voter
  attr_accessor :name, :party, :view, :politician_array
  @@politician_array = []
  def initialize(name, view)
    super
    case view
    when "liberal"
      @party = "democrat"
    when "conservative"
      @party = "republican"
    when "tea party"
      @party = "republican"
    when "socialist"
      @party = "democrat"
    when "neutral"
      @party = "independent"
    end
    @@politician_array << self
  end

  def self.list_politicians
    @@politician_array
  end


end


class VoterSimTest < Minitest::Test
  # world = World.new
  # danny = Voter.new("Danny", "liberal")
  # jeb = Politician.new("Jeb Bush", "conservative")

  #I need to create a main menu.
  # world.main_menu #done

  #I need a list of politicians #done!
  # p "This is a list of politicians: "
  # p Politician.get_politicians
  # puts ""
  
  #I need a list of voters #done!
  # p "This is a list of voters: "
  # p Voter.get_voters
  # puts ""

  #I need to create voters
  # world.create_voter #done!

  #I need to create politicians
  # world.create_politician #done!
#I need to list voters & politicians
  
  #I need to update voters & politicians
  # danny.update_voter(danny.name)
  # puts ""
  p Voter.list_voters


  puts ""
  p Politician.list_politicians


end

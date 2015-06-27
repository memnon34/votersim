#start working on the campaign mechanic.
#Get to the voting mechanic. 
#remember TDD! It has helped a lot. 
#in create politician, limit creation to 1 politican of each party. 
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
      populate_arrays
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

  def run_campaign
    #each politcian visits each voter
    #if the voter is the same as the politician, he should vote for himself.
    #if the voter is another politician, he should make a nasty coment about the other one. 
    #voters should make a comment about whether the politician has swayed him or her. 
    candidate_array = Politician.candidates
    voter_array = Voter.voters

    candidate_array.each do |candidates|
      puts "My name is #{capitalize_each_word(candidates.name)}, and you should vote for me because my #{candidates.view} policies are good for America!"
      puts candidates.name 
      if candidates.party == "republican"
        voter_array.each do |responder|
          case responder.view
          when "socialist"
            chance = rand(101)
            if chance >= 90
              responder.view = "conservative"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "liberal"
            chance = rand(101)
            if chance >= 75
              responder.view = "conservative"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "neutral"
            chance = rand(101)
            if chance >= 50
              responder.view = "conservative"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "conservative"
            chance = rand(101)
            if chance >= 25
              puts "I'm #{responder.name}, and #{candidates.name} is still my candidate!"
            else
              responder.view = "neutral"
              puts "I'm #{responder.name}, and I'm not too sure about #{candidates.name} anymore. My views are now: #{responder.view}!"
            end
          when "tea party"
            chance = rand(101)
            if chance >= 10
              puts "I'm #{responder.name}, and #{candidates.name} is still my candidate!"
            else
              responder.view = "neutral"
              puts "I'm #{responder.name}, and I'm not too sure about #{candidates.name} anymore. My views are now: #{responder.view}!"
            end
          end #end case statement
        end #end voter.each loop
      elsif candidates.party == "democrat"
        voter_array.each do |responder|
          case responder.view
          when "socialist"
            chance = rand(101)
            if chance >= 10
              puts "I'm #{responder.name}, and #{candidates.name} is still my candidate!"
            else
              responder.view = "neutral"
              puts "I'm #{responder.name}, and I'm not too sure about #{candidates.name} anymore. My views are now: #{responder.view}!"
            end
          when "liberal"
            chance = rand(101)
            if chance >= 25
              puts "I'm #{responder.name}, and #{candidates.name} is still my candidate!"
            else
              responder.view = "neutral"
              puts "I'm #{responder.name}, and I'm not too sure about #{candidates.name} anymore. My views are now: #{responder.view}!"
            end
          when "neutral"
            chance = rand(101)
            if chance >= 50
              responder.view = "liberal"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "conservative"
            chance = rand(101)
            if chance >= 75
              responder.view = "liberal"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "tea party"
            chance = rand(101)
            if chance >= 90
              responder.view = "liberal"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          end#end case statemetn
        end#end voter each loop
      else #independent candidate
        voter_array.each do |responder|
          case responder.view
          when "neutral"
            chance = rand(101)
            if chance >= 10
              puts "I'm #{responder.name}, and #{candidates.name} is my candidate!"
            else
              puts "I'm #{responder.name}. #{candidates.name} hasn't quite convinced me, but my views are still: #{responder.view}!"
            end
          when "liberal"
            chance = rand(101)
            if chance >= 75
              responder.view = "neutral"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}. My views are still: #{responder.view}!"
            end
          when "socialist"
            chance = rand(101)
            if chance >= 90
              responder.view = "neutral"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}. My views are still: #{responder.view}!"
            end
          when "conservative"
            chance = rand(101)
            if chance >= 75
              responder.view = "neutral"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}. My views are still: #{responder.view}!"
            end
          when "tea party"
            chance = rand(101)
            if chance >= 90
              responder.view = "neutral"
              puts "I'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "I'm #{responder.name}. My views are still: #{responder.view}!"
            end
          end#end case statemetn
        end#end voter each loop
      end#end if/else based on party
    end#end politician loop
  end#end run campaign method
end


class Voter
  attr_accessor :name, :view, :voter_array
  @@voter_array = []
  
  def initialize(name, view)
    @name = name
    @view = view
    @@voter_array << self
  end

  def self.voters 
    @@voter_array
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
    puts "Here is the list of voters. (Remember: politicians can vote too!)"
    @@voter_array.each do |voters|
      if voters.name.length < 9
        puts "\tVoter: #{capitalize_each_word(voters.name)}\t\t\t\tView: #{capitalize_each_word(voters.view)}" 
      elsif voters.name.length > 12
        puts "\tVoter: #{capitalize_each_word(voters.name)}\t\tView: #{capitalize_each_word(voters.view)}" 
      else
        puts "\tVoter: #{capitalize_each_word(voters.name)}\t\t\tView: #{capitalize_each_word(voters.view)}" 
      end
    end
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

  def self.candidates
    @@politician_array
  end

  def self.list_politicians
    puts "Here is the list of politicians:"
    @@politician_array.each do |politicians|
      if politicians.name.length < 9
        puts "\tPolitician: #{capitalize_each_word(politicians.name)}\t\t\tParty: #{capitalize_each_word(politicians.party)}" 
      elsif politicians.name.length > 12
        puts "\tPolitician: #{capitalize_each_word(politicians.name)}\t\tParty: #{capitalize_each_word(politicians.party)}" 
      else
        puts "\tPolitician: #{capitalize_each_word(politicians.name)}\t\t\tParty: #{capitalize_each_word(politicians.party)}" 
      end
    end
  end

end


class VoterSimTest < Minitest::Test
  world = World.new
  populate_arrays

  #I need to create a main menu.
  # world.main_menu #done

  #I need a list of politicians #done!
  # p "This is a list of politicians: "
  # p Politician.get_politicians
  # puts ""

  #I need a list of voters #done!
  # p "This is a list of voters: "
  Voter.list_voters
  puts ""

  #I need to create voters
  # world.create_voter #done!

  #I need to create politicians
  # world.create_politician #done!
#I need to list voters & politicians
  
  #I need to update voters & politicians
  # danny.update_voter(danny.name)
  # puts ""
  # p Voter.list_voters


  Politician.list_politicians

  world.run_campaign


end

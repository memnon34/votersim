
require "./votersim.rb"
include Votersim

class World#the way I have this, do I need a world class? Keep for now.

  def initialize
  end

  #main game menu. User ends up here after each method terminates.
  def self.main_menu
    puts "\nChoose from the following options: "
    puts "\t☞\tTo create a voter, press 1."
    puts "\t☞\tTo create a politician, press 2"
    puts "\t☞\tTo list all eligible voters, press 3"
    puts "\t☞\tTo list all the politicians, press 4"
    puts "\t☞\tTo update a voter, press 5"
    puts "\t☞\tTo update a politician, press 6"
    puts "\t☞\tTo send the politicians on the campaign trail, press 7"
    puts "\t☞\tTo start the election, press 8"
    puts "\n\t☞\tAt any time, press 9 to add a default list of voters and politicians."
    menu_selection(prompt_and_get)
  end

  #determines the method to run after main menu.
  def self.menu_selection(num)
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
      Voter.update_voter
    when "6"
      Politician.update_politician
    when "7"
      run_campaign
    when "8"
      run_election
    when "9"
      populate_voter_array
    else
      puts "I hope you're not trying to break my code...\n"
      puts "Please make a valid selection! Here's the menu again.\n\n"
      main_menu
    end
  end

  def self.create_voter
    puts "\nVoter name?"
    name = prompt_and_get.downcase

    puts "Voter's political views?"
    puts "Choose from the following: "
    puts "\t☞\tLiberal\n\t☞\tConservative\n\t☞\tSocialist\n\t☞\tTea Party\n\t☞\tNeutral"
    view = prompt_and_get.downcase
    view_checker(view)

    current_voter = Voter.new(name, view)
    puts "Success!"
    puts "You've created a new voter: #{capitalize_each_word(current_voter.name)}."
    puts "This voter leans: #{capitalize_each_word(current_voter.view)}."
    puts "\nPress Enter."
    prompt_and_get
    main_menu
  end

  def self.create_politician
    politician_list_length_checker #method stops this process if 3 politicians already exist.

    candidate_array = Politician.candidates #this allows code to check entries against existing politicians.

    puts "\nYou can create one Democrat, one Republican, and one Independent."
    puts "Politician name?"
    name = prompt_and_get.downcase #my method for prompting and turning downcasing user input.

    politician_name_checker_create(name) #checks to see if the name has more than 0 characters.

    puts "Politician's political views?"
    puts "Choose from the following: "
    puts "\t☞\tLiberal\n\t☞\tConservative\n\t☞\tSocialist\n\t☞\tTea Party\n\t☞\tNeutral"
    puts "\n\t*Tip: \tLiberals and Socialists will become Democrats.\n\t\tTea Party & Conservatives will be Republicans.\n\t\tNeutral will run for the Independents."

    view = prompt_and_get.downcase
    view_checker(view) #checks for valid input

    party_checker(view) if candidate_array.length > 0  #if a politician already exists, this will make sure the new one can't join the same party

    current_politician = Politician.new(name, view)
    puts "Success!"
    puts "You've created a new politician: #{capitalize_each_word(current_politician.name)}."
    puts "This politician leans: #{capitalize_each_word(current_politician.view)}."
    puts "And his/her political party is: #{capitalize_each_word(current_politician.party)} "
    puts "Press Enter."
    prompt_and_get
    main_menu
  end

  #sends politicians to debate each other, then to campaign for voters.
  def self.run_campaign
    candidate_array = Politician.candidates
    voter_array = Voter.voters

    #this the debate section. Candidates say a speech, goes through all voters, and only politicians respond.
    #loop within a loop! First time I can do that successfully :)
    puts "\nFirst, the candidates will debate!"
    candidate_array.each do |candidates|
      puts "\nI'm #{capitalize_each_word(candidates.name)}, and I would like you to join my party and support my candidacy."
      voter_array.each do |responder|
        if responder.name == candidates.name
          puts "\tOf course, my #{candidates.view} views are best for our country!"
        elsif responder.is_a? Politician
          puts "\tI, #{capitalize_each_word(responder.name)}, am with the #{capitalize_each_word(responder.party)}s, and your #{candidates.view} views will ruin America!"
        else
        end
      end
    end

    #this deletes the politicians from the voter array for the campaign mechanic.
    voter_array = voter_array - candidate_array

    #loopin to talk to each voter.
    puts "\nNow let's send the candidates on the campaign trail!"
    candidate_array.each do |candidates|
      puts "\nMy name is #{capitalize_each_word(candidates.name)}, and you should vote for me because my #{candidates.view} policies are good for America!\n\n"

      #case statement checks to see if voters' minds are changed based on the percentages given in the assignment.
      #I added an independent candidate, and his stats I played with to reflect what I assumed would align with reality.
      if candidates.party == "republican"
        voter_array.each do |responder|
          case responder.view
          when "socialist"
            chance = rand(101)
            if chance >= 90
              responder.view = "conservative"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "liberal"
            chance = rand(101)
            if chance >= 75
              responder.view = "conservative"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "neutral"
            chance = rand(101)
            if chance >= 50
              responder.view = "conservative"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "conservative"
            chance = rand(101)
            if chance >= 25
              puts "\tI'm #{responder.name}, and #{candidates.name} is still my candidate!"
            else
              responder.view = "neutral"
              puts "\tI'm #{responder.name}, and I'm not too sure about #{candidates.name} anymore. My views are now: #{responder.view}!"
            end
          when "tea party"
            chance = rand(101)
            if chance >= 10
              puts "\tI'm #{responder.name}, and #{candidates.name} is still my candidate!"
            else
              responder.view = "neutral"
              puts "\tI'm #{responder.name}, and I'm not too sure about #{candidates.name} anymore. My views are now: #{responder.view}!"
            end
          end #end case statement
        end #end voter.each loop

      elsif candidates.party == "democrat"
        voter_array.each do |responder|
          case responder.view
          when "socialist"
            chance = rand(101)
            if chance >= 10
              puts "\tI'm #{responder.name}, and #{candidates.name} is still my candidate!"
            else
              responder.view = "neutral"
              puts "\tI'm #{responder.name}, and I'm not too sure about #{candidates.name} anymore. My views are now: #{responder.view}!"
            end
          when "liberal"
            chance = rand(101)
            if chance >= 25
              puts "\tI'm #{responder.name}, and #{candidates.name} is still my candidate!"
            else
              responder.view = "neutral"
              puts "\tI'm #{responder.name}, and I'm not too sure about #{candidates.name} anymore. My views are now: #{responder.view}!"
            end
          when "neutral"
            chance = rand(101)
            if chance >= 50
              responder.view = "liberal"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "conservative"
            chance = rand(101)
            if chance >= 75
              responder.view = "liberal"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          when "tea party"
            chance = rand(101)
            if chance >= 90
              responder.view = "liberal"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}, and #{candidates.name} didn't change my mind. I'm still hold my #{responder.view} views!"
            end
          end#end case statemetn
        end#end voter each loop

      else #independent candidate
        voter_array.each do |responder|
          case responder.view
          when "neutral"
            chance = rand(101)
            if chance >= 10
              puts "\tI'm #{responder.name}, and #{candidates.name} is my candidate!"
            else
              puts "\tI'm #{responder.name}. #{candidates.name} hasn't quite convinced me, but my views are still: #{responder.view}!"
            end
          when "liberal"
            chance = rand(101)
            if chance >= 75
              responder.view = "neutral"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}. My views are still: #{responder.view}!"
            end
          when "socialist"
            chance = rand(101)
            if chance >= 90
              responder.view = "neutral"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}. My views are still: #{responder.view}!"
            end
          when "conservative"
            chance = rand(101)
            if chance >= 75
              responder.view = "neutral"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}. My views are still: #{responder.view}!"
            end
          when "tea party"
            chance = rand(101)
            if chance >= 90
              responder.view = "neutral"
              puts "\tI'm #{responder.name}, and #{candidates.name} convinced me to change my political view to: #{responder.view}!"
            else
              puts "\tI'm #{responder.name}. My views are still: #{responder.view}!"
            end
          end#end case statemetn
        end#end voter each loop
      end#end if/else based on party
    end#end politician loop

    #this sends them straight to the election. No need to go back to the main menu after the campaign...
    #though I guess technically you could add more stuff and campaign again? Maybe that's work adding?
    puts "\nThe campaign season has ended, and the voters have solidified their views."
    puts "The only thing left to do is start the election! Press enter to continue."
    prompt_and_get
    run_election
  end#end run campaign method

  #runs the election
  def self.run_election
    #to tally votes
    democrat_votes = 0
    republican_votes = 0
    independent_votes = 0
    voter_array = Voter.voters
    candidate_array = Politician.candidates

    puts "\nOkay! Voters, hit the ballot boxes!!!\n\n"

    #I was going to get fancy and put in another element of chance here to reflect voters' changing their
    #minds at the last minute when they enter the ballot boxes...but I ran out of energy. The decision
    #mechanic happens in campaign, and
    voter_array.each do |voters|
      if voters.is_a? Politician
        case voters.party
        when "republican"
          puts "I, #{capitalize_each_word(voters.name)}, voted for myself!"
          republican_votes += 1
        when "democrat"
          puts "I, #{capitalize_each_word(voters.name)}, voted for myself!"
          democrat_votes += 1
        when "independent"
          puts "I, #{capitalize_each_word(voters.name)}, voted for myself!"
          independent_votes += 1
        end
      else
        case voters.view
        when "socialist"
          puts "I'm #{voters.name}, and I voted Democrat."
          democrat_votes += 1
        when "liberal"
          puts "I'm #{voters.name}, and I voted Democrat."
          democrat_votes += 1
        when "conservative"
          puts "I'm #{voters.name}, and I voted Republican."
          republican_votes += 1
        when "tea party"
          puts "I'm #{voters.name}, and I voted Republican."
          republican_votes += 1
        when "neutral"
          puts "I'm #{voters.name}, and I voted for the Independent."
          independent_votes += 1
        end #end case statement
      end#end if statement
    end#end loop

    puts "\nReady for the winner?"
    prompt_and_get

    "\nAnd the winner is.......".each_char {|x| print x ; sleep(0.05) }

    candidate_array.each do |candidates|
      if democrat_votes > republican_votes && democrat_votes > independent_votes
        if candidates.party == "democrat"
          puts "#{capitalize_each_word(candidates.name)} is the winner! The #{capitalize_each_word(candidates.party)}s remain in the White House!"
        end
      elsif republican_votes > democrat_votes && republican_votes > independent_votes
        if candidates.party == "republican"
          puts "#{capitalize_each_word(candidates.name)} is the winner! The #{capitalize_each_word(candidates.party)}s retake the White House!"
        end
      else
        if candidates.party == "independent"
          puts "#{capitalize_each_word(candidates.name)} is the winner! The #{capitalize_each_word(candidates.party)}s win the White House for the first time in history!"
        end
      end
    end

    puts "\nFinal vote tally:"
    puts "\tDemocrats: #{democrat_votes}"
    puts "\tRepublicans: #{republican_votes}"
    puts "\tIndependents: #{independent_votes}"
    World.ending

  end#end run election

  def self.ending
    "Thank you for playing!!".each_char {|x| print x ; sleep (0.05)}
    "\n\n\t\t\t\t\t\t\tTHE END!\n\n\n".each_char{|x| print x ; sleep(0.1)}
    abort("Make sure you vote in 2016!!!\n\n\n\n")
  end



end #end of World Class.


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

  def self.update_voter
    puts "\nWhich voter would you like to update? Enter the voter's full name here: "
    name = prompt_and_get.downcase

    puts "Would you like to update the voter's name? Enter 'yes' or 'no'."
    yes_or_no = prompt_and_get.downcase

    yes_or_no_checker(yes_or_no)

    if yes_or_no == "yes"
      puts "Enter the voter's new name!"
      new_name = prompt_and_get.downcase
      @@voter_array.each do |voters|
        if voters.name == name
          puts "#{capitalize_each_word(voters.name)} has been updated to #{capitalize_each_word(new_name)}."
          voters.name = new_name
          puts "#{capitalize_each_word(new_name)} currently leans #{voters.view}. Update this voter's view."
          puts "Enter liberal, conservative, socialist, tea party, or neutral."
          view = prompt_and_get.downcase
          update_view_checker(view)
          voters.view = view
          puts "#{capitalize_each_word(voters.name)} now leans #{voters.view}."
          World.main_menu
        end #end inner if
      end #end loop
    else
      puts "Update #{capitalize_each_word(name)}'s political views."
      puts "Enter liberal, conservative, socialist, tea party, or neutral."
      view = prompt_and_get.downcase
      update_view_checker(view)
      @@voter_array.each do |voters|
        if voters.name == name
          voters.view = view
          puts "#{capitalize_each_word(voters.name)} now leans #{voters.view}."
          World.main_menu
        end #end inner if
      end #end loop
    end #end outer if

  end #end update method


  def self.list_voters

    if @@voter_array.length == 0
      puts "No voters yet!"
      World.main_menu
    else
      puts "Here is the list of voters. (Remember: politicians can vote too!)"
      @@voter_array.each do |voters|
          print "\tVoter: #{capitalize_each_word(voters.name)}".ljust(50), "View: #{capitalize_each_word(voters.view)}\n"
      end #end loop
      World.main_menu
    end #end outer if statement

  end

end #end voter class

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

    if @@politician_array.length == 0
      puts "No politicians yet!"
      World.main_menu
    else
      puts "Here is the list of politicians:"

      @@politician_array.each do |politicians|
        print "\tPolitician: #{capitalize_each_word(politicians.name)}".ljust(50), "Party: #{capitalize_each_word(politicians.party)}\n"
      end

    end
    World.main_menu
  end

  # def self.politician_view_checker(newview)
  #   candidate_array = Politician.candidates

  #   candidate_array.each do |search|
  #     if search.view == newview
  #       puts "\nYou can't make a politician with that view because you'll create too many politicians for the respective party."
  #       puts "Go back and try again."
  #       Politician.update_politician
  #     end
  #   end

  # end

  def self.update_politician
    puts "\nWhich politician would you like to update? Enter the politician's full name, or press 1 to return to the main menu. "
    name = prompt_and_get.downcase
    if name == "1"
      World.main_menu
    else
      politician_name_checker_update(name)
    end

    puts "Would you like to update the politican's name? Enter 'yes' or 'no'."
    yes_or_no = prompt_and_get.downcase

    yes_or_no_checker_politician(yes_or_no)

    puts "Update this politician's political views?"
    puts "Remember:\n\tLiberals and socialists become Democrats\n\tTea partiers and conservatives become Republicans\n\tNeutral people become Independents."
    puts "\nAND, remember you can only have one politician from each party."
    puts "\nEnter liberal, conservative, socialist, tea party, or neutral."
    view = prompt_and_get.downcase
    view_checker_politician(view) #checks for valid input
    update_party_checker(name, view) #checks to make sure there isn't another politician of that same party

    if yes_or_no == "yes"
      puts "Enter the politician's new name!"
      new_name = prompt_and_get.downcase

      @@politician_array.each do |politicians|###
        if politicians.name == name
          puts "#{capitalize_each_word(politicians.name)} has been updated to #{capitalize_each_word(new_name)}."
          politicians.name = new_name
          politicians.view = view
          puts "#{capitalize_each_word(politicians.name)} now leans #{politicians.view}"
          if politicians.view == "liberal" || politicians.view == "socialist"
            politicians.party = "democrat"
          elsif politicians.view == "conservative" || politicians.view == "tea party"
            politicians.party = "republican"
          else
            politicians.party = "independent"
          end
          puts "And #{capitalize_each_word(politicians.name)} joins the #{capitalize_each_word(politicians.party)}s."
          World.main_menu
        end #end inner if
      end #end loop

    else
      @@politician_array.each do |politicians|
        if politicians.name == name
          politicians.view = view
          if politicians.view == "liberal" || politicians.view == "socialist"
            politicians.party = "democrat"
          elsif politicians.view == "conservative" || politicians.view == "tea party"
            politicians.party = "republican"
          else
            politicians.party = "independent"
          end
          puts "#{capitalize_each_word(politicians.name)} now leans #{politicians.view} and joins the #{capitalize_each_word(politicians.party)}s."
          World.main_menu
        end
      end
    end

  end

end


puts "\nWelcome to the 2016 Presidential Election Simulator!!"
World.main_menu

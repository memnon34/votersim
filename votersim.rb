module Votersim
    #for user input
  def prompt_and_get
    print ">  "
    STDIN.gets.chomp!
  end

  def capitalize_each_word(words)
    words.split.map(&:capitalize).join(' ')
  end

  def populate_voter_array
    Voter.new("Mike Garcia", "socialist")
    Voter.new("Roberto Perez", "tea party")
    Voter.new("Andrew Velo", "conservative")
    Voter.new("Sonia Gala", "liberal")
    Voter.new("Alirio Fenton", "neutral")
    Voter.new("Dennis Linus", "liberal")
    Voter.new("Cheryl Flint", "conservative")
    Voter.new("Joana Karma", "neutral")
    Voter.new("Harold Miner", "neutral")
    Voter.new("Luiza Felipe", "neutral")
    puts "\n\tDefault voters have been added!"
    populate_politician_array
  end 

  def populate_politician_array
    politician_list_length_checker
    candidate_array = Politician.candidates

    if candidate_array.length == 0
      Politician.new("hilary clinton", "liberal")
      Politician.new("bernie sanders", "neutral")
      Politician.new("jeb bush", "conservative")
    elsif candidate_array.length == 1
      if candidate_array[0].party == "democrat"
        Politician.new("bernie sanders", "neutral")
        Politician.new("jeb bush", "conservative")
      elsif candidate_array[0].party == "republican"
        Politician.new("hilary clinton", "liberal")
        Politician.new("bernie sanders", "neutral")
      else
        Politician.new("jeb bush", "conservative")
        Politician.new("hilary clinton", "liberal")
      end#ends the if statement
    elsif candidate_array.length == 2
      if candidate_array[0].party == "democrat"
        if candidate_array[1].party == "republican"
          Politician.new("bernie sanders", "neutral")
        end
      elsif candidate_array[0].party == "democrat"
        if candidate_array[1].party == "independent"
          Politician.new("jeb bush", "conservative")
        end
      elsif candidate_array[0].party == "republican"
        if candidate_array[1].party == "democrat"
          Politician.new("bernie sanders", "neutral")
        end
      elsif candidate_array[0].party == "republican"
        if candidate_array[1].party == "independent"
          Politician.new("hilary clinton", "liberal")
        end
      elsif candidate_array[0].party == "independent"
        if candidate_array[1].party == "republican"        
          Politician.new("hilary clinton", "liberal")
        end
      else
        Politician.new("jeb bush", "conservative")
      end#end if/else
    else
      puts "Something went wrong adding politicians! Try creating them manually."
    end#end outer if/eslse

    puts "\n\tDefault politicians have been added!"
    World.main_menu

  end

  def yes_or_no_checker(string)
    if string != "yes" && string != "no"
      puts "Not a valid entry. Type carefully! "
      Voter.update_voter
    end
  end

  def yes_or_no_checker_politician(string)
    if string != "yes" && string != "no"
      puts "Not a valid entry. Type carefully! "
      Politician.update_politician
    end
  end

  #checks the politicians name during the create method
  def politician_name_checker_create(string)
    if string.length < 1
      puts "Please enter a valid name."
      World.create_politician
    end
  end

  def politician_name_checker_update(string)### not working. 
    # candidate_array = Politician.candidates
    search_keys = []
  
    
    if string.length < 1
      puts "Please enter a valid name."
      Politician.update_politician
    end

    Politician.candidates.each do |search| 
      search_keys << search.name
    end
      
    if search_keys.include?(string)
      return
    else 
      puts "Not found! Try again."
      Politician.update_politician
    end

  end

  #checks if user entered a valid view
  def view_checker(view) 
    if view != "liberal" && view != "conservative" && view != "tea party" && view != "socialist" && view != "neutral"
      puts "That's not a valid selection. Type carefully! Try again."
      World.create_politician
    end
  end

  def view_checker_politician(view) 
    if view != "liberal" && view != "conservative" && view != "tea party" && view != "socialist" && view != "neutral"
      puts "That's not a valid selection. Type carefully! Try again."
      Politician.update_politician
    end
  end

  def update_view_checker(view)
    if view != "liberal" && view != "conservative" && view != "tea party" && view != "socialist" && view != "neutral"
      puts "That's not a valid selection. Type carefully! Try again."
      Voter.update_voter
    end
  end

  def politician_list_length_checker
    candidate_array = Politician.candidates #this allows code to check entries against existing politicians.
    
    if candidate_array.length == 3
      puts "\nYou've created all the politicians already! Do something else."
      World.main_menu
    end

  end

  #checks if there is already one candidate from party. 
  def party_checker(view)
    

    candidate_array = Politician.candidates
    #looping through to determine if a politician of that party exits
    candidate_array.each do |search|
      if search.party == "democrat"
        if view == "liberal"
          puts "There already is a democratic candidate."
          World.main_menu
        elsif view == "socialist"
          puts "There already is a democratic candidate."
          World.main_menu
        end
      elsif search.party == "republican"
        if view == "conservative"
          puts "There already is a republican candidate."
          World.main_menu
        elsif view == "tea party"
          puts "There already is a republican candidate."
          World.main_menu
        end
      elsif search.party == "independent"
        if view == "neutral"
          puts "There already is an independent candidate."
          World.main_menu
        end
      else
        puts "Not valid. Try again."
        World.main_menu
      end 

    end  

  end#end of party checker method

  #####Working right now, but would like to add the ability to update view
  ####if it's the candidate from the same party. 

  # def update_party_checker(view) # needs to be fixed.
    
  #   candidate_array = Politician.candidates
  #   #looping through to determine if a politician of that party exits
  #   candidate_array.each do |search|
  #     if search.party == "democrat"
  #       if view == "liberal"
  #         puts "There already is a democratic candidate."
  #         puts "Return to the main menu."
  #         World.main_menu
  #       elsif view == "socialist"
  #         puts "There already is a democratic candidate."
  #         puts "Return to the main menu."
  #         World.main_menu
  #       end
  #     elsif search.party == "republican"
  #       if view == "conservative"
  #         puts "There already is a republican candidate."
  #         puts "Return to the main menu."
  #         World.main_menu
  #       elsif view == "tea party"
  #         puts "There already is a republican candidate."
  #         puts "Return to the main menu."
  #         World.main_menu
  #       end
  #     elsif search.party == "independent"
  #       if view == "neutral"
  #         puts "There already is an independent candidate."
  #         puts "Return to the main menu."
  #         World.main_menu
  #       end
  #     else
  #       puts "Not valid. Try again."
  #       puts "Return to the main menu."
  #       World.main_menu
  #     end 

  #   end  

  # end#end of updte party checker method


  def update_party_checker(name, view) # needs to be fixed.
    
    candidate_array = Politician.candidates #looping through to determine if a politician of that party exits
    
    if view == "liberal" || view == "socialist"
      candidate_array.each do |search|
        if search.party == "democrat" && search.name == name
          search.view == view
          puts "Success! #{capitalize_each_word(name)}'s political view has been updated to #{view}."
        elsif search.party == "democrat"
          puts "There already is a democratic candidate. You can only have one of each."
          puts "Return to the main menu."
          World.main_menu
        end
      end
    elsif view == "conservative" || view == "tea party"
      candidate_array.each do |search|
        if search.party == "republican" && search.name == name
          search.view == view
          puts "Success! #{capitalize_each_word(name)}'s political view has been updated to #{view}."
        elsif search.party == "republican"
          puts "There already is a republican candidate. You can only have one of each."
          puts "Return to the main menu."
          World.main_menu        
        end
      end
    elsif view == "neutral"
      candidate_array.each do |search|
        if search.party == "independent" && search.name == name 
          search.view = view
          puts "Success! #{capitalize_each_word(name)}'s political view has been updated to #{view}."
        elsif search.party == "independent"
          puts "There already is a republican candidate. You can only have one of each."
          puts "Return to the main menu."
          World.main_menu 
        end
      end
    else
      puts "Error. Return to the main menu."
      World.main_menu
    end

  end


end#end of module



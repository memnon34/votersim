module Votersim
    #for user input
  def prompt_and_get
    print ">  "
    STDIN.gets.chomp!
  end

  def capitalize_each_word(words)
    words.split.map(&:capitalize).join(' ')
  end

  def populate_arrays
    Voter.new("Mike Garcia", "socialist")
    Voter.new("Roberto Perez", "Tea Party")
    Voter.new("Andrew Velo", "conservative")
    Voter.new("Sonia Gala", "liberal")
    Voter.new("Alirio Fenton", "neutral")
    Voter.new("Dennis Linus", "liberal")
    Voter.new("Cheryl Flint", "conservative")
    Voter.new("Joana Karma", "neutral")
    Voter.new("Harold Miner", "neutral")
    Voter.new("Luiza Felipe", "neutral")
    Politician.new("Hilary Clinton", "liberal")
    Politician.new("Bernie Sanders", "neutral")
    Politician.new("Jeb Bush", "conservative")
  end 

end
module Votersim
    #for user input
  def prompt_and_get
    print ">  "
    STDIN.gets.chomp!
  end

  def capitalize_each_word(words)
    words.split.map(&:capitalize).join(' ')
  end

end
module Voter
    #for user input
  def prompt_and_get
    print ">  "
    STDIN.gets.chomp!
  end

end
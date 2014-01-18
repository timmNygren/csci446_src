class Player
	@health = warrior.health
	
  def play_turn(warrior)
    # add your code here
    if warrior.health < 20 and !warrior.feel.enemy?
    	warrior.rest!
  	elsif warrior.feel.enemy?
  		warrior.attack!
  	else
  		warrior.walk!
  	end
  end
end

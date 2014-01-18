class Player

  def play_turn(warrior)
    # add your code here

    # @state(warrior)
    if warrior.health < 20 and @health <= warrior.health
    	warrior.rest!
  	elsif warrior.feel.enemy?
  		warrior.attack!
  	else
  		warrior.walk!
  	end

  	@health = warrior.health
  end

  # def self.update(warrior)
  # 	@state(warrior)
  # end

  # def rest(warrior)
  # 	if @health < 20
  # 		warrior.rest!
  # 	else
  # 		@state = move_forward
  # 		self.update(warrior)
  # 	end
  # end

  # def move_forward(warrior)
  # 	if warrior.feel.enemy?
  # 		@state = attack
  # 		self.update(warrior)
  # 	elsif @health - warrior.health == 0 and @health != 20
  # 		@state = rest
  # 		self.update(warrior)
  # 	else
  # 		warrior.walk!
  # 	end
  # end

  # def attack(warrior)
  # 	if !warrior.feel.enemy?
  # 		@state = move_forward
  # 		self.update(warrior)
  # 	else
  # 		warrior.attack!
  # 	end
  # end

end

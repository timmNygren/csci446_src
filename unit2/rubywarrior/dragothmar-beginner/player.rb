class Player

  def play_turn(warrior)
    # add your code here
    @health = warrior.health if @health == nil

  	puts @health
  	puts warrior.health

    @state ||= self.method(:move_forward)

    update(warrior)

  	@health = warrior.health
  end

  def update(warrior)
  	@state.call(warrior)
  end

  def rest(warrior)

  	difference = @health - warrior.health

  	if @health == 20 or difference > 0
  		@state = self.method(:move_forward)
  		update(warrior)
  	else
  		warrior.rest!
  	end
  end

  def move_forward(warrior)

  	difference = @health - warrior.health

  	if warrior.feel.enemy?
  		@state = self.method(:attack)
  		update(warrior)
  	elsif difference <= 0  and  @health != 20
  		@state = self.method(:rest)
  		update(warrior)
  	elsif warrior.feel.captive?
  		@state = self.method(:rescue)
  		update(warrior)
  	else
  		warrior.walk!
  	end
  end

  def rescue(warrior)
  	if !warrior.feel.captive?
  		@state = self.method(:move_forward)
  		update(warrior)
  	else
  		warrior.rescue!
  	end
  end

  def attack(warrior)
  	if !warrior.feel.enemy?
  		@state = self.method(:move_forward)
  		update(warrior)
  	else
  		warrior.attack!
  	end
  end

end

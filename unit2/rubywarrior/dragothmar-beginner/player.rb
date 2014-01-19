class Player

	# Threshhold for when to run
	THRESHHOLD = 10
	# Max health of the player
	MAX_HEALTH = 20

  def play_turn(warrior)
    # add your code here
    # Initialize health first time to keep track
    @health ||= warrior.health
    # Set the state, if this is the first time use move
    @state ||= self.method(:move)
    # Set the current direction of the warrior
    @direction ||= 0

    look_ahead = warrior.look

    look_ahead.each do |creature|
    	if creature.captive?
    		# If the first thing encountered is a captive, move towards to rescue
    		@state = self.method(:move)
    		break
    	elsif creature.enemy?
    		# If the first thing encountered is an enemy, shoot it
    		@state = self.method(:attack)
    		break
    	else
    		# Nothing was seen from look so player should just move
    		@state = self.method(:move)
    	end
    end

    # Update the action
    update(warrior)
    # Get current health to compare after enemy turn
  	@health = warrior.health
  end

  # Calles the state of the warrior
  def update(warrior)
  	@state.call(warrior)
  end

  # The warrior rests when he has taken no damage and his health is
  # not full
  def rest(warrior)

  	# Get the difference of previous health and current health to
  	# determine if damage was taken
  	difference = @health - warrior.health

  	# If warrior health is full continue moving
  	if @health == MAX_HEALTH
  		@state = self.method(:move)
  		update(warrior)
  	# If warrior is taking damage during resting, run
  	elsif difference > 0
  		@state = self.method(:run)
  		update(warrior)
  	else
  		warrior.rest!
  	end
  end

  # Moves the warrior in a direction
  def move(warrior)

  	# Get the difference of previous health and current health to
  	# determine if damage was taken
  	difference = @health - warrior.health

  	# Don't want to die, so run
  	if warrior.health < THRESHHOLD and difference > 0
  		@state = self.method(:run)
  		update(warrior)
  	# If the player hasn't taken damage and health is not full set 
  	# the state to rest and update
  	elsif difference <= 0  and  @health != MAX_HEALTH
  		@state = self.method(:rest)
  		update(warrior)
  	# If there is an enemy ahead, set the state to attack and update
  	elsif warrior.feel.enemy?
  		@state = self.method(:attack)
  		update(warrior)
  	# If there is a captive ahead set the state to rescue and update
  	elsif warrior.feel.captive?
  		@state = self.method(:rescue)
  		update(warrior)
  	# If there is a wall, turn around
  	elsif warrior.feel.wall?
  		warrior.pivot!
  	else
  		# Otherwise walk
  		warrior.walk!
  	end
  end

  # Warrior runs until not taking damage
  def run(warrior)

  	difference = @health - warrior.health
  	# Warrior isn't taking damage and can move
  	if difference <= 0
  		@state = self.method(:move)
  		update(warrior)
  	else
  		warrior.walk!(:backward)
  	end
  end

  # Rescue a captive that has been found. 
  def rescue(warrior)
  	if !warrior.feel.captive?
  		@state = self.method(:move)
  		update(warrior)
  	else
  		warrior.rescue!
  	end
  end

  # Attack the enemy in front
  def attack(warrior)

  	# If the warrior is lower than the threshhold, he should stop attacking and run
  	if warrior.health < THRESHHOLD
  		@state = self.method(:run)
  		update(warrior)
  		return
  	end

  	# Look ahead for more enemies
  	look_ahead = warrior.look
  	# Shoot any enemy encountered from looking
  	look_ahead.each {|ahead_enemy| return warrior.shoot! if ahead_enemy.enemy? }

  	# If no enemies are found, player moves forward
  	@state = self.method(:move)
  	update(warrior)

  end

end

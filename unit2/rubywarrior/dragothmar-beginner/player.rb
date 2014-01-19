class Player

	@@directions = [:forward, :backward]

	THRESHHOLD = 10
	MAX_HEALTH = 20
	NUM_DIRECTIONS = 2

  def play_turn(warrior)
    # add your code here
    # Initialize health first time to keep track
    @health ||= warrior.health
    # Set the state, if this is the first time use move
    @state ||= self.method(:move)
    # Set the current direction of the warrior
    @direction ||= 0

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

  	# If warrior health is full or has taken damage, move forward to
  	# attack enemy
  	if @health == MAX_HEALTH
  		@state = self.method(:move)
  		update(warrior)
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
  		warrior.pivot!
  		# update(warrior)
  	# If the player hasn't taken damage and health is not full set 
  	# the state to rest and update
  	elsif difference <= 0  and  @health != MAX_HEALTH
  		@state = self.method(:rest)
  		update(warrior)
  	# If there is an enemy ahead, set the state to attack and update
  	elsif warrior.feel.enemy?#(@@directions[@direction]).enemy?
  		@state = self.method(:attack)
  		update(warrior)
  	# If there is a captive ahead set the state to rescue and update
  	elsif warrior.feel.captive?#(@@directions[@direction]).captive?
  		@state = self.method(:rescue)
  		update(warrior)
  	elsif warrior.feel.wall?#(@@directions[@direction]).wall?
  		warrior.pivot!
  		# update(warrior)
  	else
  		# Otherwise walk
  		warrior.walk!#(@@directions[@direction])
  	end
  end

  # Warrior runs until not taking damage
  def run(warrior)

  	difference = @health - warrior.health

  	if difference <= 0
  		@state = self.method(:move)
  		update(warrior)
  	else
  		warrior.walk!#(@@directions[ ( @direction + 1 ) % NUM_DIRECTIONS])
  	end
  end

  # Rescue a captive that has been found. 
  def rescue(warrior)
  	if !warrior.feel.captive?#(@@directions[@direction]).captive?
  		@state = self.method(:move)
  		update(warrior)
  	else
  		warrior.rescue!#(@@directions[@direction])
  	end
  end

  # Attack the enemy in front
  def attack(warrior)

  	if warrior.health < THRESHHOLD
  		@state = self.method(:run)
  		warrior.pivot!
  	elsif !warrior.feel.enemy?#(@@directions[@direction]).enemy?
  		@state = self.method(:move)
  		update(warrior)
  	else
  		warrior.attack!#(@@directions[@direction])
  	end
  end

end

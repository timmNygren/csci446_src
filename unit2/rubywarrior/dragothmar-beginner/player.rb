# Grader Comment 
#
# @author Timm Nygren
#
# *Not all lines for each use are obviously not listed*
# Instance variables were used on lines 26, 28, 41, 46, and others
# Class variables used on lines 13, 15, 17, 30, 33, 78, 114
# Constants used as class variables on line 13, 15, 17, same as class variable lines
# Array used on lines 20, 51, 63, 99
# Hash used on lines 18, 31, 34, 99, 164
# Functions used as states. Definitions starting on lines 46, 50, 73, 92, 144, 158, 170

class Player

	# @@THRESHHOLD for when to run
	@@THRESHHOLD = 4
	# Max health of the player
	@@MAX_HEALTH = 20
	# Some room information
	@@room_information = {
		:captives => 0,
		:starting_look => true,
		:spaces_ahead => [0,0,0]
	}

  def play_turn(warrior)
    # add your code here
    # Initialize health first time to keep track
    @health ||= warrior.health
    # Set the state, if this is the first time use move
    @state ||= self.method(:move)

    if @@room_information[:starting_look]
	    scope_the_room(warrior, :forward)
	    scope_the_room(warrior, :backward)
	    @@room_information[:starting_look] = false
	  end

    # Update the action
    update(warrior)
    # Update the vision of the spaces ahead
    scope_the_room(warrior, :forward)
    # Get current health to compare after enemy turn
  	@health = warrior.health
  end

  # Calles the state of the warrior
  def update(warrior)
  	@state.call(warrior)
  end

  def scope_the_room(warrior, direction)
  	# Look at what is ahead
  	look_ahead = warrior.look(direction) 

  	# Remember what is in front of us
  	if direction.equal?(:forward)
  		@@room_information[:spaces_ahead] = look_ahead
  	end

  	# Check in front and behind to look for captives to save
  	if @@room_information[:starting_look]		
	  	look_ahead.each do |creature|
		    	if creature.captive?
		    		# Remember the captive to save
		    		@@room_information[:captives] += 1
		    	end
		    end
		  end
	  end


  # The warrior rests when he has taken no damage and his health is
  # not full
  def rest(warrior)
  	# Get the difference of previous health and current health to
  	# determine if damage was taken
  	difference = @health - warrior.health

  	# If warrior health is full continue moving
  	if @health == @@MAX_HEALTH
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
  	# Used to check if an enemy is near
  	enemy_near = false
  	# Scope the room in front
  	scope_the_room(warrior, :forward)

  	# Look at the spaces from warrior.look
  	@@room_information[:spaces_ahead].each do |space|
  		if space.captive?
  			# If there is a captive nearest, we break so that the warrior moves forward
  			break
  		elsif space.enemy?
  			# Checks for the first enemy. Break if one is found and set enemy_near to true
  			enemy_near = true
  			break
  		end
  	end

  	# Get the difference of previous health and current health to
  	# determine if damage was taken
  	difference = @health - warrior.health

  	# Don't want to die, so run
  	if warrior.health <= @@THRESHHOLD and difference > 0
  		@state = self.method(:run)
  		update(warrior)
  	# If the player hasn't taken damage and health is not full set 
  	# the state to rest and update
  	elsif difference <= 0  and  @health != @@MAX_HEALTH
  		@state = self.method(:rest)
  		update(warrior)
  	# If there is a captive ahead set the state to rescue and update
  	elsif warrior.feel.captive?
  		@state = self.method(:rescue)
  		update(warrior)
  	# If there is an enemy ahead, set the state to attack and update
  	elsif warrior.feel.enemy? or enemy_near
  		@state = self.method(:attack)
  		update(warrior)
  	# If there is a wall, turn around
  	elsif warrior.feel.wall?
  		warrior.pivot!
  	# If we found the stairs but are missing captives, we turn around to save them!
  	elsif warrior.feel.stairs? and @@room_information[:captives] > 0
  		warrior.pivot!
  	else
  		# Otherwise walk
  		warrior.walk!
  	end
  end

  # Warrior runs until not taking damage
  def run(warrior)
  	# Get the difference of our health to know if we need to keep moving backwards
  	difference = @health - warrior.health

  	# Warrior isn't taking damage and can perform another action
  	if difference <= 0
  		@state = self.method(:move)
  		update(warrior)
  	else
  		warrior.walk!(:backward)
  	end
  end

  # Rescue a captive that has been found. 
  def rescue(warrior)
  	# Move after freeing the captive
  	if !warrior.feel.captive?
  		@state = self.method(:move)
  		update(warrior)
  	else
  		@@room_information[:captives] -= 1
  		warrior.rescue!
  	end
  end

  # Attack the enemy in front
  def attack(warrior)
  	# Get the difference to know if we must move forward when being attacked from behind
  	difference = @health - warrior.health

  	# If the warrior is lower than the @@THRESHHOLD, he should stop attacking and run
  	if warrior.health <= @@THRESHHOLD
  		@state = self.method(:run)
  		update(warrior)
  		return
  	end
  	# Update our vision of what is in front of us
  	scope_the_room(warrior, :forward)

  	# attack an enemy at max range if there are no closer enemies
  	if @@room_information[:spaces_ahead][2].enemy? and !@@room_information[:spaces_ahead][0].enemy? and !@@room_information[:spaces_ahead][1].enemy?
  		warrior.shoot!
  		return
  	# If there is not an enemy in front and we are taking damage from the back
  	elsif !@@room_information[:spaces_ahead][0].enemy? and difference > 0
  		warrior.walk!
  		return
  	# Destroy what is in front of the warrior
  	elsif @@room_information[:spaces_ahead][0].enemy?
  		warrior.attack!
  		return
  	else
	  	# Shoot any enemy encountered from looking
	  	@@room_information[:spaces_ahead].each {|ahead_enemy| return warrior.shoot! if ahead_enemy.enemy? }
	  end

  	# If no enemies are found, player moves forward
  	@state = self.method(:move)
  	update(warrior)
  end
end
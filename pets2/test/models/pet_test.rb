require 'test_helper'

class PetTest < ActiveSupport::TestCase

	fixtures :pets
  
  test "pet attributes must not be empty" do
  	pet = Pet.new
  	assert pet.invalid?
  	assert pet.errors[:name].any?
  	assert pet.errors[:age].any?
  	assert pet.errors[:breed].any?
  	assert pet.errors[:coloring].any?
  	assert pet.errors[:habits].any?
  	assert pet.errors[:image_url].any?
  	assert pet.errors[:gender].any?
  end

	test "pet age must be positive" do
  	pet = Pet.new(:name => 'Dog',
  				  			:breed => 'mybreed',
  				  			:coloring => 'tan',
  				  			:habits => 'hyper',
  				  			:image_url => 'stuff.png',
  				  			:gender => 'female')
  	pet.age = -1
  	assert pet.invalid?
  	assert_equal "must be greater than or equal to 1",
  		pet.errors[:age].join('; ')

  	pet.age = 0
  	assert pet.invalid?
  	assert_equal "must be greater than or equal to 1",
  		pet.errors[:age].join('; ')

    pet.age = 1
    assert pet.valid?
  end

  def new_pet(image_url)
  	Pet.new(:name		=> 'Dog',
  		    	:breed => 'mybreed',
  		    	:age => 6,
  					:coloring => 'tan',
  					:habits => 'hyper',
  		    	:image_url => image_url,
  					:gender => 'female')
  end

  test "image_url" do
  	ok = %w{ fred.gif joe.jpg john.png JOE2.JPG fReD.JpG 
  						http://www.stuff.com/morestuff/image.Gif }
  	bad = %w{ fred.gi joe.jg sup.doc super.gif/bad john.jpg.ruo }

  	ok.each do |url|
  		assert new_pet(url).valid?, "#{url} shouldn't be invalid"
  	end

  	bad.each do |url|
  		assert new_pet(url).invalid?, "#{url} should be invalid"
  	end
  end
end

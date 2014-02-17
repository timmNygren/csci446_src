# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Pet.delete_all

Pet.create(:name => 'Buddy',
	:age => 15,
	:breed => 'Golden Retriever',
	:coloring =>
		%{<p>
			Golden coat with white chest hair.
		</p>},
	:habits =>
		%{<p>
			Playful and loving.
		</p>},
	:image_url => 'buddy.jpg',
	:gender => 'male')

Pet.create(:name => 'Tazz',
	:age => 11,
	:breed => 'Minpin',
	:coloring =>
		%{<p>
			Red/rust color.
			</p>},
	:habits =>
		%{<p>
			Playful and loud.
			</p>},
	:image_url => 'tazz.jpg',
	:gender => 'male')

Pet.create(:name => 'Zephyr',
	:age => 5,
	:breed => 'Bernese Mountain Dog',
	:coloring =>
		%{<p>
			Main black coat with white chest and hints of orange. Prominent
			features are the large white spot on top with
			full white snout. 
			</p>},
	:habits =>
		%{<p>
			Very relaxed most times. Can get hyper.
			</p>},
	:image_url => 'zephyr.jpg',
	:gender => 'female')
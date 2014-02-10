# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all
# . . .
Product.create!(title: 'Programming Ruby 1.9 & 2.0',
				description:
				%{<p>
					Ruby is the fastest growing and most exciting dynamic language
					out there. If you need to get working programs delivered fast,
					you should add Ruby to your toolbox.
					</p>},
					image_url: 'ruby.jpg',
					price: 49.95)
# . . .
Product.create!(:title => 'CoffeeScript',
  :description => 
    %{<p>
        CoffeeScript is JavaScript done right. It provides all of JavaScript and yadda
        yadda yadda. More filler words for listing products.
      </p>},
  :image_url =>   'cs.jpg',    
  :price => 42.95)
# . . .
Product.create!(:title => 'Rails Test Prescriptions',
	:description =>
		%{<p>
				Rails Test Prescriptions is a comprehensive guide to testing
				this awesome application. Test test test test test test test.
				</p>},
	:image_url => 'rtp.jpg',
	:price => 43.85)
# . . .


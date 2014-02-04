class Pet < ActiveRecord::Base
	validates :name, :breed, :image_url, :coloring, :habits, :gender, :presence => true
	validates :age, :numericality => {:greater_than_or_equal_to => 1}
end

class Pet < ActiveRecord::Base
	has_one :adopts

	validates :name, :age, :breed, :coloring, :habits, :image_url, :gender, presence: true
	validates :age, numericality: {greater_than_or_equal_to: 1}
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
end

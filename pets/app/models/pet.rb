class Pet < ActiveRecord::Base
	default_scope :order => 'name'

	validates :name, :breed, :image_url, :coloring, :habits, :gender, :presence => true
	validates :age, :numericality => {:greater_than_or_equal_to => 1}
	validates :image_url, :format => {
		:with => %r{\.(gif|jpg|png)\z}i,
		:message => 'must be a URL for GIF, JPG, or PNG image.'
	}
	validates_uniqueness_of :name, scope: [:age, :breed]
end

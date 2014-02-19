class Pet < ActiveRecord::Base
	has_many :consider_adopts
	has_one :foster_parent

	before_destroy :ensure_not_referenced_by_any_consider_adopt

	validates :name, :age, :breed, :coloring, :habits, :image_url, :gender, presence: true
	validates :age, numericality: {greater_than_or_equal_to: 1}
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}

	private

		# ensure that there are no considered pets referencing this pet
		def ensure_not_referenced_by_any_consider_adopt
			if consider_adopts.empty?
				return true
			else
				errors.add(:base, 'Considered Pet present')
				return false
			end
		end
end

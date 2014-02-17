class Consider < ActiveRecord::Base
	has_many :consider_adopts, dependent: :destroy

	def add_pet(pet_id)
		current_pet = consider_adopts.find_by(pet_id: pet_id)
		if !current_pet
			current_pet = consider_adopts.build(pet_id: pet_id)
		end
		current_pet
	end
end

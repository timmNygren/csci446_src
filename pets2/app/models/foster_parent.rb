class FosterParent < ActiveRecord::Base
	belongs_to :pet

	validates :name, :address, :email, presence: true
end

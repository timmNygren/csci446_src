class CreateConsiderAdopts < ActiveRecord::Migration
  def change
    create_table :consider_adopts do |t|
      t.references :pet, index: true
      t.belongs_to :consider, index: true

      t.timestamps
    end
  end
end

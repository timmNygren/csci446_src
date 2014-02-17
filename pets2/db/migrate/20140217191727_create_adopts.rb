class CreateAdopts < ActiveRecord::Migration
  def change
    create_table :adopts do |t|
      t.references :pet, index: true

      t.timestamps
    end
  end
end

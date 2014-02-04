class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.text :coloring
      t.text :habits
      t.string :image_url
      t.string :gender

      t.timestamps
    end
  end
end

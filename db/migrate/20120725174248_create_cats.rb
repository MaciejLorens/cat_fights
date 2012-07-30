class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :image
      t.float :total_points

      t.timestamps
    end
  end
end

class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :Cat
      t.float :value

      t.timestamps
    end
    add_index :votes, :Cat_id
  end
end

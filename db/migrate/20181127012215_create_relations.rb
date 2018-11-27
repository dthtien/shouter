class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.integer :follower_id
      t.integer :following_id

      t.timestamps
    end

    add_index :relations, [:follower_id, :following_id], unique: true
  end
end

class CreateShouts < ActiveRecord::Migration[5.2]
  def change
    create_table :shouts do |t|
      t.text :body

      t.timestamps
    end
  end
end

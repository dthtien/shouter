class AddUserIdToShouts < ActiveRecord::Migration[5.2]
  def change
    add_reference :shouts, :user, foreign_key: true
  end
end

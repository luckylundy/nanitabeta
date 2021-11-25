class AddUserIdToMicroposts < ActiveRecord::Migration[6.0]
  def change
    add_reference :microposts, :user, foreign_key: true
  end
end

class CreateMicroposts < ActiveRecord::Migration[6.0]
  def change
    create_table :microposts do |t|
      t.string :photo
      t.text :detail

      t.timestamps
    end
  end
end

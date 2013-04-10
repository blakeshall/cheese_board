class CreateActiveLists < ActiveRecord::Migration
  def change
    create_table :active_lists do |t|
      t.integer :user_id
      t.integer :cheddar_list_id
      t.string :title
      t.timestamps
    end
  end
end

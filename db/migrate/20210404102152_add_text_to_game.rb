class AddTextToGame < ActiveRecord::Migration[6.1]
  def change
  	add_column :games, :text, :text, null: false
  end
end

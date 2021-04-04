class AddAnsweredPositionsToGame < ActiveRecord::Migration[6.1]
  def change
  	add_column :games, :answered_positions, :text
  end
end

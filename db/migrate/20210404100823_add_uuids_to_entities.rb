class AddUuidsToEntities < ActiveRecord::Migration[6.1]
  def change
  	add_column :tasks, :uuid, :string, null: false, unique: true
  	add_column :games, :uuid, :string, null: false, unique: true
  end
end

class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
    	t.references :game, foreign_key: true, null: false
      t.integer :position, null: false
      t.text :question
      t.timestamps
    end
  end
end

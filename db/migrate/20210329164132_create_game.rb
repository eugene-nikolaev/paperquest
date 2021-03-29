class CreateGame < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
    	t.string :name, null: false
    	t.string :pincode, null: false, unique: true
      t.timestamps
    end
  end
end

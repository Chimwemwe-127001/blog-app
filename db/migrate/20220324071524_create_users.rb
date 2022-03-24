class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :Name
      t.string :Photo
      t.text :Bio
      t.integer :Posts_Counter ,default: 0,null: false

      t.timestamps
    end
  end
end
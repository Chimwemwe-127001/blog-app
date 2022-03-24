class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :users, null: false, foriegn_key: true, index:true
      t.string :Title
      t.string :Text
      t.integer :Comments_Counter ,default: 0,null: false
      t.integer :Likes_Counter ,default: 0,null: false

      t.timestamps
    end
  end
end

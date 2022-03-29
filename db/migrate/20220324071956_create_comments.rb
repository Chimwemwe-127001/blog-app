class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :users, null: false, foriegn_key: true, index:true
      
      t.text :Text

      t.timestamps
    end
  end
end

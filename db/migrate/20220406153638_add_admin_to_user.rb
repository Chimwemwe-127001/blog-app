class AddAdminToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :string, null: false, default: 'default'
    add_column :users, :api_token, :string
  end
end

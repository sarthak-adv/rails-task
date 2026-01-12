class FixUsersTable < ActiveRecord::Migration[8.1]
  def change
    remove_column :users, :password, :string
    add_column :users, :role, :integer, null: false, default: 0
    add_index :users, :email, unique: true
  end
end

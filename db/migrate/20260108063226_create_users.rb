class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.integer :org_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end

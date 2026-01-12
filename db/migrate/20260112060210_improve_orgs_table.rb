class ImproveOrgsTable < ActiveRecord::Migration[8.1]
  def change
    add_index :orgs, :name, unique: true
    add_column :orgs, :status, :string, default: "active"
  end
end

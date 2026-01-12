class FixRulesTable < ActiveRecord::Migration[8.1]
  def change
    rename_column :rules, :desc, :description
    change_column :rules, :key, :string, null: false
    change_column :rules, :rule_type, :string, null: false
    add_index :rules, :key, unique: true
  end
end

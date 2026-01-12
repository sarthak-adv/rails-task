class CreateOrgRules < ActiveRecord::Migration[8.1]
  def change
    create_table :org_rules do |t|
      t.references :org, null: false, foreign_key: true
      t.references :rule, null: false, foreign_key: true
      t.boolean :enabled, null: false, default: true
      t.json :value

      t.timestamps
    end

    add_index :org_rules, [ :org_id, :rule_id ], unique: true
  end
end

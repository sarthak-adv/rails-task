class CreateRules < ActiveRecord::Migration[8.1]
  def change
    create_table :rules do |t|
      t.text :key
      t.text :desc
      t.text :rule_type

      t.timestamps
    end
  end
end

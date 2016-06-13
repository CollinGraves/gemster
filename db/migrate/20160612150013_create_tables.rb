class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
      t.integer :number
      t.integer :seats

      t.timestamps null: false
    end
    add_index :tables, :number
  end
end

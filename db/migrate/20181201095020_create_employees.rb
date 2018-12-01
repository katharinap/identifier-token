class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.string :identifier
      t.references :company, foreign_key: true

      t.timestamps
    end
    add_index :employees, :identifier, unique: true
  end
end

class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :first_name
      t.string :last_name
      t.string :ctoken
      t.references :employee, foreign_key: true

      t.timestamps
    end
    add_index :clients, :ctoken, unique: true
  end
end

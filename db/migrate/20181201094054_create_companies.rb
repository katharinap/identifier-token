class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :identity

      t.timestamps
    end
    add_index :companies, :identity, unique: true
  end
end

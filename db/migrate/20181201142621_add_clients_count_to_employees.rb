class AddClientsCountToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :clients_count, :integer, default: 0
  end
end

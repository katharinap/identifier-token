class AddEmployeesCountToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :employees_count, :integer, default: 0
  end
end

# frozen_string_literal: true

desc 'Resets the employees_count attribute of existing companies'

task employees_counter: :environment do
  Company.reset_column_information
  Company.pluck(:id).each do |id|
    Company.reset_counters id, :employees
  end
end

desc 'Resets the clients_count attribute of existing employees'

task clients_counter: :environment do
  Employee.reset_column_information
  Employee.pluck(:id).each do |id|
    Employee.reset_counters id, :clients
  end
end

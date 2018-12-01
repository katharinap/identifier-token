# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

100.times do
  company = Company.create(name: Faker::Company.name)

  employee_count = (5..50).to_a.sample
  employee_count.times do
    employee = company.employees.create(first_name: Faker::Name.first_name,
                                        last_name: Faker::Name.last_name)

    client_count = (2..10).to_a.sample
    client_count.times do
      employee.clients.create(first_name: Faker::Name.first_name,
                              last_name: Faker::Name.last_name)
    end
  end
end

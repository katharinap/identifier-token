# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'destroying an employee' do
  it 'allows the user to destroy an employee' do
    company = create(:company)
    employees = create_list(:employee, 2, company: company)
    employee = employees.first
    create_list(:client, 1, employee: employee)

    visit(company_employees_path(company))

    within("#employee-#{employee.id}") do
      click_on('Destroy')
    end

    expect(current_path).to eq(company_employees_path(company))
    expect { page.find_by_id("#employee-#{employee.id}") }.to raise_error(Capybara::ElementNotFound)
    expect(page).to have_content('Employee was successfully destroyed.')
    expect(Employee.find_by(id: employee.id)).to be_nil
  end
end

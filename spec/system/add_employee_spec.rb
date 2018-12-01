# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'adding an employee to a company' do
  it 'allows the user to add an employee' do
    company = create(:company)
    create_list(:employee, 2, company: company)
    visit(company_employees_path(company))
    click_on('New Employee')
    expect(current_path).to eq(new_company_employee_path(company))
    fill_in('First Name', with: 'Erika')
    fill_in('Last Name', with: 'Mustermann')
    click_on('Create Employee')

    expect(current_path).to eq(company_employees_path(company))
    expect(page).to have_content('Employee was successfully created.')

    employee = Employee.last
    within("#employee-#{employee.id}") do
      expect(page).to have_selector('.full-name', text: 'Erika Mustermann')
      expect(page).to have_selector('.client-count', text: 0)
    end
  end
end

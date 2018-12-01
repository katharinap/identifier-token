# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'editing an employee of a company' do
  it 'allows the user to edit an employee' do
    company = create(:company)
    employees = create_list(:employee, 2, company: company)
    employee = employees.first

    visit(company_employees_path(company))

    within("#employee-#{employee.id}") do
      click_on('Edit')
    end

    expect(current_path).to eq(edit_employee_path(employee))
    fill_in('First Name', with: 'Joe')
    fill_in('Last Name', with: 'Black')
    click_on('Update Employee')

    expect(current_path).to eq(company_employees_path(company))
    expect(page).to have_content('Employee was successfully updated.')

    within("#employee-#{employee.id}") do
      expect(page).to have_selector('.full-name', text: 'Joe Black')
    end
  end
end

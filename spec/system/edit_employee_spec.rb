# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'editing an employee of a company' do
  it 'allows the user to edit an employee' do
    company1 = create(:company, name: 'Company One')
    company2 = create(:company, name: 'Company Two')

    employees = create_list(:employee, 2, company: company1)
    employee = employees.first

    visit(company_employees_path(company1))

    within("#employee-#{employee.id}") do
      click_on('Edit')
    end

    expect(current_path).to eq(edit_employee_path(employee))
    fill_in('First Name', with: 'Joe')
    fill_in('Last Name', with: 'Black')
    select('Company Two', from: 'Company')
    click_on('Update Employee')

    expect(current_path).to eq(company_employees_path(company2))
    expect(page).to have_content('Employee was successfully updated.')

    within("#employee-#{employee.id}") do
      expect(page).to have_selector('.full-name', text: 'Joe Black')
    end
    employee.reload
    expect(employee.company_id).to eq(company2.id)
  end
end

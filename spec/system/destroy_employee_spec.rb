# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'destroying an employee' do
  it 'allows the user to destroy an employee that does not have any clients' do
    company = create(:company)
    employee = create(:employee, company: company)

    visit(company_employees_path(company))

    within("#employee-#{employee.id}") do
      button = find_link('Destroy')
      expect(button[:class]).not_to include('disabled')
      click_on('Destroy')
    end

    expect(current_path).to eq(company_employees_path(company))
    expect { page.find_by_id("#employee-#{employee.id}") }.to raise_error(Capybara::ElementNotFound)
    expect(page).to have_content('Employee was successfully destroyed.')
    expect(Employee.find_by(id: employee.id)).to be_nil
  end

  it 'disables the destroy button for employees with assigned clients' do
    company = create(:company)
    employee = create(:employee, company: company)
    create(:client, employee: employee)

    visit(company_employees_path(company))

    within("#employee-#{employee.id}") do
      button = find_link('Destroy')
      expect(button[:class]).to include('disabled')
    end
  end
end

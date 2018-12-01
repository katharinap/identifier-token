# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'listing employees of a company' do
  it 'shows the relevant attributes of an employee' do
    companies = create_list(:company, 2)
    employees = create_list(:employee, 2, company: companies.first)
    create_list(:employee, 2, company: companies.last)
    create_list(:client, 3, employee: employees.first)
    visit(company_employees_path(companies.first))

    expect(page).to have_selector('.employee', count: 2)

    employee = employees.first
    within("#employee-#{employee.id}") do
      expect(page).to have_selector('.full-name', text: employee.full_name)
      expect(page).to have_selector('.identifier', text: employee.identifier)
      expect(page).to have_selector('.client-count', text: 3)
      expect(page).to have_link('3', href: employee_clients_path(employee))
    end
  end
end

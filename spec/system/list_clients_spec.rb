# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'listing clients of one employee' do
  it 'shows the relevant attributes of the clients' do
    employees = create_list(:employee, 2)
    clients = create_list(:client, 3, employee: employees.first)
    create_list(:client, 1, employee: employees.last)
    visit(employee_clients_path(employees.first))

    expect(page).to have_selector('.client', count: 3)

    client = clients.first
    within("#client-#{client.id}") do
      expect(page).to have_selector('.full-name', text: client.full_name)
      expect(page).to have_selector('.ctoken', text: client.ctoken)
    end
  end
end

RSpec.describe 'listing clients of one company' do
  it 'shows the relevant attributes of the clients' do
    company = create(:company)
    employees = create_list(:employee, 2, company: company)
    clients = create_list(:client, 3, employee: employees.first)
    create_list(:client, 1, employee: employees.last)
    visit(company_clients_path(company))

    expect(page).to have_selector('.client', count: 4)

    client = clients.first
    employee = employees.first
    within("#client-#{client.id}") do
      expect(page).to have_selector('.full-name', text: client.full_name)
      expect(page).to have_selector('.ctoken', text: client.ctoken)
      expect(page).to have_selector('.employee-full-name', text: employee.full_name)
      expect(page).to have_link(employee.full_name, href: employee_clients_path(employee))
    end
  end
end

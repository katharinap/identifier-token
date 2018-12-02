# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'adding an client to a employee' do
  it 'allows the user to add a client from the employee specific client view' do
    employee = create(:employee)
    create_list(:client, 2, employee: employee)
    visit(employee_clients_path(employee))
    click_on('New Client')
    expect(current_path).to eq(new_employee_client_path(employee))
    fill_in('First Name', with: 'Client')
    fill_in('Last Name', with: 'One')
    click_on('Create Client')

    expect(current_path).to eq(employee_clients_path(employee))
    expect(page).to have_content('Client was successfully created.')

    client = Client.last
    within("#client-#{client.id}") do
      expect(page).to have_selector('.full-name', text: 'Client One')
    end
  end

  it 'allows the user to add a client from the company specific client view' do
    company = create(:company)
    employee1 = create(:employee, company: company)
    employee2 = create(:employee, company: company, first_name: 'Employee', last_name: 'Two')
    create_list(:client, 2, employee: employee1)

    visit(company_clients_path(company))
    click_on('New Client')

    fill_in('First Name', with: 'Client')
    fill_in('Last Name', with: 'Two')
    select('Employee Two', from: 'Employee')
    click_on('Create Client')

    expect(current_path).to eq(employee_clients_path(employee2))
    expect(page).to have_content('Client was successfully created.')

    client = Client.last
    within("#client-#{client.id}") do
      expect(page).to have_selector('.full-name', text: 'Client Two')
      expect(page).to have_selector('.employee-full-name', text: 'Employee Two')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'editing a client of a employee' do
  it 'allows the user to edit a client' do
    employee = create(:employee)
    clients = create_list(:client, 2, employee: employee)
    client = clients.first

    visit(employee_clients_path(employee))

    within("#client-#{client.id}") do
      click_on('Edit')
    end

    expect(current_path).to eq(edit_client_path(client))
    fill_in('First Name', with: 'Fred')
    fill_in('Last Name', with: 'Green')
    click_on('Update Client')

    expect(current_path).to eq(employee_clients_path(employee))
    expect(page).to have_content('Client was successfully updated.')

    within("#client-#{client.id}") do
      expect(page).to have_selector('.full-name', text: 'Fred Green')
    end
  end

  it 'allows the client to be assigned to another employee of the same company' do
    company = create(:company)
    employee1 = create(:employee, first_name: 'Alice', last_name: 'One', company: company)
    employee2 = create(:employee, first_name: 'Bob', last_name: 'Two', company: company)
    client = create(:client, employee: employee1)

    other_company = create(:company)
    create(:employee, first_name: 'Carol', last_name: 'Three', company: other_company)

    visit(edit_client_path(client))

    expect { select('Carol Three', from: 'Employee') }.to raise_error(Capybara::ElementNotFound)

    select('Bob Two', from: 'Employee')
    click_on('Update Client')
    expect(current_path).to eq(employee_clients_path(employee2))

    client.reload
    expect(client.employee_id).to eq(employee2.id)
  end
end

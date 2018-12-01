# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'adding an client to a employee' do
  it 'allows the user to add a client' do
    employee = create(:employee)
    create_list(:client, 2, employee: employee)
    visit(employee_clients_path(employee))
    click_on('New Client')
    expect(current_path).to eq(new_employee_client_path(employee))
    fill_in('First Name', with: 'Max')
    fill_in('Last Name', with: 'Mustermann')
    click_on('Create Client')

    expect(current_path).to eq(employee_clients_path(employee))
    expect(page).to have_content('Client was successfully created.')

    client = Client.last
    within("#client-#{client.id}") do
      expect(page).to have_selector('.full-name', text: 'Max Mustermann')
    end
  end
end

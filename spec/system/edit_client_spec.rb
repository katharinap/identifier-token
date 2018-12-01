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
    fill_in('First name', with: 'Fred')
    fill_in('Last name', with: 'Green')
    click_on('Update Client')

    expect(current_path).to eq(employee_clients_path(employee))
    expect(page).to have_content('Client was successfully updated.')

    within("#client-#{client.id}") do
      expect(page).to have_selector('.full-name', text: 'Fred Green')
    end
  end
end

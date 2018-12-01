# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'destroying a client' do
  it 'allows the user to destroy a client' do
    employee = create(:employee)
    clients = create_list(:client, 2, employee: employee)
    client = clients.first

    visit(employee_clients_path(employee))

    within("#client-#{client.id}") do
      click_on('Destroy')
    end

    expect(current_path).to eq(employee_clients_path(employee))
    expect { page.find_by_id("#client-#{client.id}") }.to raise_error(Capybara::ElementNotFound)
    expect(page).to have_content('Client was successfully destroyed.')
    expect(Client.find_by(id: client.id)).to be_nil
  end
end

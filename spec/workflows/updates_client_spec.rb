# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdatesClient do
  it 'updates the client name attributes' do
    client = create(:client)
    UpdatesClient.new(client, first_name: 'Alice', last_name: 'Smith')
    client.reload
    expect(client.first_name).to eq('Alice')
    expect(client.last_name).to eq('Smith')
  end

  it 'updates the client employee_id if the new employee works for the same company as the current one' do
    company = create(:company)
    employee1, employee2 = create_list(:employee, 2, company: company)
    client = create(:client, employee: employee1)
    UpdatesClient.new(client, employee_id: employee2.id)
    client.reload
    expect(client.employee_id).to eq(employee2.id)
  end

  it 'does not update the client employee_id if the new employee works for another company than current one' do
    companies = create_list(:company, 2)
    employee1 = create(:employee, company: companies.first)
    client = create(:client, employee: employee1)
    employee2 = create(:employee, company: companies.last)
    UpdatesClient.new(client, employee_id: employee2.id)
    client.reload
    expect(client.employee_id).to eq(employee1.id)
  end
end

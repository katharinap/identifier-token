# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating an client' do
  it 'does not allow to update the ctoken attribute' do
    client = create(:client)
    old_ctoken = client.ctoken
    put client_path(client), params: { client: { first_name: 'Foo', last_name: 'Bar' } }
    expect(response).to have_http_status(:redirect)

    client.reload
    expect(client.first_name).to eq('Foo')
    expect(client.last_name).to eq('Bar')
    expect(client.ctoken).to eq(old_ctoken)
  end

  it 'does not allow to select an employee from another company than the current one' do
    companies = create_list(:company, 2)
    employee1 = create(:employee, company: companies.first)
    client = create(:client, employee: employee1)
    employee2 = create(:employee, company: companies.last)

    put client_path(client), params: { client: { employee_id: employee2.id } }

    client.reload
    expect(client.employee_id).to eq(employee1.id)
  end
end

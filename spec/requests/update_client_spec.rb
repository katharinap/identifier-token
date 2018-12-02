# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating an client' do
  it 'does not allow to update the ctoken attribute' do
    client = create(:client)
    old_ctoken = client.ctoken
    put client_path(client), params: { client: { first_name: 'Foo', last_name: 'Bar' } }
    expect(response).to have_http_status(:redirect)
    client = Client.find(client.id)
    expect(client.first_name).to eq('Foo')
    expect(client.last_name).to eq('Bar')
    expect(client.ctoken).to eq(old_ctoken)
  end
end

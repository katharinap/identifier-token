# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating a company' do
  it 'does not allow to update the identity attribute' do
    company = create(:company)
    old_identity = company.identity
    put company_path(company), params: { company: { name: 'Next Generation Company', identity: 'ABCD' } }
    expect(response).to have_http_status(:redirect)
    company = Company.find(company.id)
    expect(company.name).to eq('Next Generation Company')
    expect(company.identity).to eq(old_identity)
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'listing companies' do
  it 'shows all the companies' do
    create_list(:company, 5)
    visit(companies_path)
    expect(page).to have_selector('.company', count: 5)
  end

  it 'shows the relevant attributes of a company' do
    company = create(:company)
    employees = create_list(:employee, 2, company: company)
    create_list(:client, 3, employee: employees.first)
    visit(companies_path)
    within("#company-#{company.id}") do
      expect(page).to have_selector('.name', text: company.name)
      expect(page).to have_selector('.identity', text: company.identity)
      expect(page).to have_selector('.employee-count', text: 2)
      expect(page).to have_selector('.client-count', text: 3)
    end
  end
end

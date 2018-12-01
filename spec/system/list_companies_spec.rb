# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'listing companies' do
  it 'shows all the companies with their relevant attributes' do
    companies = create_list(:company, 5)
    company = companies.first
    employees = create_list(:employee, 2, company: company)
    create_list(:client, 3, employee: employees.first)

    visit(companies_path)
    within("#company-#{company.id}") do
      expect(page).to have_selector('.name', text: company.name)
      expect(page).to have_selector('.identity', text: company.identity)
      expect(page).to have_selector('.employee-count', text: 2)
      expect(page).to have_link('2', href: company_employees_path(company))
      expect(page).to have_selector('.client-count', text: 3)
      expect(page).to have_link('3', href: company_clients_path(company))
    end
  end
end

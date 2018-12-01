# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'adding a company' do
  it 'allows the user to add a company' do
    visit(companies_path)
    click_on('New Company')
    expect(current_path).to eq(new_company_path)
    fill_in('Name', with: 'Unicorn LLC')
    click_on('Create Company')

    expect(current_path).to eq(companies_path)
    expect(page).to have_content('Company was successfully created.')

    company = Company.last
    within("#company-#{company.id}") do
      expect(page).to have_selector('.name', text: 'Unicorn LLC')
    end
  end
end

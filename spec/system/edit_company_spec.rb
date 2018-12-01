# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'editing a company' do
  it 'allows the user to edit a company' do
    company = create(:company)
    visit(companies_path)

    within("#company-#{company.id}") do
      click_on('Edit')
    end

    expect(current_path).to eq(edit_company_path(company))
    fill_in('Name', with: 'MyCorp')
    click_on('Update Company')

    expect(current_path).to eq(companies_path)
    expect(page).to have_content('Company was successfully updated.')

    within("#company-#{company.id}") do
      expect(page).to have_selector('.name', text: 'MyCorp')
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'destroying a company' do
  it 'allows the user to destroy a company' do
    company = create(:company, name: 'Obsolete Company')
    visit(companies_path)

    within("#company-#{company.id}") do
      click_on('Destroy')
    end

    expect(current_path).to eq(companies_path)
    expect(page).to have_content('Company was successfully destroyed.')

    expect { page.find_by_id("#company-#{company.id}") }.to raise_error(Capybara::ElementNotFound)

    expect(Company.find_by(id: company.id)).to be_nil
  end
end

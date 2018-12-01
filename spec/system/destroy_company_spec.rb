# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'destroying a company' do
  it 'allows the user to destroy a company' do
    create(:company, name: 'Obsolete Company')
    visit(companies_path)
    expect(page).to have_content('Obsolete Company')
    click_on('Destroy')

    expect(current_path).to eq(companies_path)
    expect(page).not_to have_content('Obsolete Company')
    expect(page).to have_content('Company was successfully destroyed.')
  end
end

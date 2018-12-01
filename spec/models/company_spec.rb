# frozen_string_literal: true

# == Schema Information
#
# Table name: companies
#
#  id         :integer          not null, primary key
#  name       :string
#  identity   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '.create' do
    it 'sets the identity attribute to a string of the format ABCD:EFGH' do
      company = create(:company)
      expect(company.identity).to match(/^[A-Z]{4}:[A-Z]{4}$/)
    end
  end

  describe '#employees_count' do
    it 'returns the number of associated employees' do
      company = create(:company)
      create_list(:employee, 2, company: company)
      expect(company.employees_count).to eq(2)
    end
  end

  describe '#clients_count' do
    it 'returns the number of associated clients' do
      company = create(:company)
      employees = create_list(:employee, 2, company: company)
      create_list(:client, 2, employee: employees.first)
      create_list(:client, 3, employee: employees.last)
      expect(company.clients_count).to eq(5)
    end
  end
end

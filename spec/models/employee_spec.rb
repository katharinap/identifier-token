# frozen_string_literal: true

# == Schema Information
#
# Table name: employees
#
#  id         :integer          not null, primary key
#  first_name :string
#  last_name  :string
#  identifier :string
#  company_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe '.create' do
    it 'sets the identifier attribute to a string of the format AB-GH-KL' do
      employee = create(:employee)
      expect(employee.identifier).to match(/^[A-Z]{2}-[A-Z]{2}-[A-Z]{2}$/)
    end
  end

  describe '#clients_count' do
    it 'returns the number of associated clients' do
      employee = create(:employee)
      create_list(:client, 3, employee: employee)
      expect(employee.clients_count).to eq(3)
    end
  end

  describe '#full_name' do
    it 'returns a string with first and last name' do
      employee = create(:employee, first_name: 'John', last_name: 'Miller')
      expect(employee.full_name).to eq('John Miller')
    end
  end
end

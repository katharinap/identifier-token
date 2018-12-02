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

  describe '#co_workers' do
    it 'returns all other the employees that work at the same company' do
      company = create(:company)
      employee, *co_workers = create_list(:employee, 3, company: company)
      create(:employee)
      expect(employee.co_workers).to eq(co_workers)
    end

    it 'returns the employee as well if include_self is set to true' do
      company = create(:company)
      employees = create_list(:employee, 3, company: company)
      create(:employee)
      expect(employees.first.co_workers(include_self: true)).to eq(employees)
    end
  end

  describe '#allow_destroy?' do
    it 'returns false if the employee still has any clients assigned' do
      employee = create(:employee)
      create(:client, employee: employee)
      expect(employee.allow_destroy?).to be_falsey
    end

    it 'returns true if the employee does not have any clients assigned' do
      employee = create(:employee)
      expect(employee.allow_destroy?).to be_truthy
    end
  end
end

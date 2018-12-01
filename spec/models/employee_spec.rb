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
      company = Company.create(name: 'Another Inc')
      employee = company.employees.create(first_name: 'First', last_name: 'Last')
      expect(employee.identifier).to match(/^[A-Z]{2}-[A-Z]{2}-[A-Z]{2}$/)
    end
  end
end

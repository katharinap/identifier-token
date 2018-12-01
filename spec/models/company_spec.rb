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
end

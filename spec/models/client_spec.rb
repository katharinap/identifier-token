# frozen_string_literal: true

# == Schema Information
#
# Table name: clients
#
#  id          :integer          not null, primary key
#  first_name  :string
#  last_name   :string
#  ctoken      :string
#  employee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '.create' do
    it 'sets the ctoken attribute to a string of the format AB-GH-KL' do
      client = create(:client)
      expect(client.ctoken).to match(/^[A-Z]{2}-[A-Z]{2}-[A-Z]{2}$/)
    end
  end

  describe '#full_name' do
    it 'returns a string with first and last name' do
      client = create(:client, first_name: 'Sarah', last_name: 'Jones')
      expect(client.full_name).to eq('Sarah Jones')
    end
  end
end

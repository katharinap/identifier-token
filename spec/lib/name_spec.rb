# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Name do
  describe '#full_name' do
    it 'returns a string with first and last name' do
      name = Name.new('Jane', 'Doe')
      expect(name.full_name).to eq('Jane Doe')
    end
  end
end

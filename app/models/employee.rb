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

class Employee < ApplicationRecord
  belongs_to :company

  before_create :set_identifier_token

  private

  def set_identifier_token
    self.identifier = generate_token
  end

  def generate_token
    loop do
      token = [token_sequence, token_sequence, token_sequence].join('-')
      break token unless self.class.where(identifier: token).exists?
    end
  end

  def token_sequence
    Array.new(2) { ('A'..'Z').to_a.sample }.join
  end
end

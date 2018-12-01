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

class Company < ApplicationRecord
  before_create :set_identity_token

  private

  def set_identity_token
    self.identity = generate_token
  end

  def generate_token
    loop do
      token = [token_sequence, token_sequence].join(':')
      break token unless self.class.where(identity: token).exists?
    end
  end

  def token_sequence
    Array.new(4) { ('A'..'Z').to_a.sample }.join
  end
end

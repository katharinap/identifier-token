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
  has_many :employees, dependent: :destroy
  has_many :clients, -> { distinct }, through: :employees

  has_unique_identifier :identity,
                        segment_count: 2,
                        segment_size: 4,
                        delimiter: ':'

  def clients_count
    employees.map(&:clients_count).reduce(0, :+)
  end
end

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
  belongs_to :company, counter_cache: true
  has_many :clients, dependent: :destroy

  has_unique_identifier :identifier,
                        segment_count: 3,
                        segment_size: 2,
                        delimiter: '-'

  def full_name
    "#{first_name} #{last_name}"
  end
end

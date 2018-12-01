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
  has_many :employees

  has_unique_identifier :identity,
                        segment_count: 2,
                        segment_size: 4,
                        delimiter: ':'
end

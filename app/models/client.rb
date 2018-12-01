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

class Client < ApplicationRecord
  belongs_to :employee, counter_cache: true

  has_unique_identifier :ctoken,
                        segment_count: 3,
                        segment_size: 2,
                        delimiter: '-'

  delegate :full_name, to: :name

  private

  def name
    Name.new(first_name, last_name)
  end
end

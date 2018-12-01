# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    sequence :name do |n|
      "The Company #{n}"
    end
  end

  factory :employee do
    first_name { 'Jane' }
    last_name  { 'Doe' }
    company
  end

  factory :client do
    first_name { 'Jane' }
    last_name  { 'Doe' }
    employee
  end
end

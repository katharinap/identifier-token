# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { 'Something Inc' }
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

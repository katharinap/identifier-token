# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating an employee' do
  it 'does not allow to update the identifier attribute' do
    employee = create(:employee)
    old_identifier = employee.identifier
    put employee_path(employee), params: { employee: { first_name: 'Foo', last_name: 'Bar' } }
    expect(response).to have_http_status(:redirect)
    employee = Employee.find(employee.id)
    expect(employee.first_name).to eq('Foo')
    expect(employee.last_name).to eq('Bar')
    expect(employee.identifier).to eq(old_identifier)
  end
end

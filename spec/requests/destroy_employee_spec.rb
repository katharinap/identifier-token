# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'updating an employee' do
  it 'allows to destroy an employee without clients' do
    employee = create(:employee)

    delete employee_path(employee)
    expect(response).to have_http_status(:redirect)

    expect(Employee.find_by(id: employee.id)).to be_nil
  end

  it 'does not allow to destroy an employee that has clients assigned' do
    employee = create(:employee)
    create(:client, employee: employee)

    delete employee_path(employee)
    expect(response).to have_http_status(:redirect)

    expect(Employee.find_by(id: employee.id)).not_to be_nil
  end
end

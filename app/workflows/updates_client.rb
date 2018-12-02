# frozen_string_literal: true

# wrapper for the logic to update client attributes
class UpdatesClient
  def initialize(client, params)
    @client = client
    @attributes = params.to_h
    update
  end

  private

  attr_reader :client, :attributes

  def update
    maybe_remove_employee_id
    client.update(attributes)
  end

  def maybe_remove_employee_id
    return unless attributes[:employee_id]
    return if attributes[:employee_id] == client.employee_id
    return if employee_companies_match?

    attributes.delete(:employee_id)
  end

  def employee_companies_match?
    previous_employee = client.employee
    new_employee = Employee.find(attributes[:employee_id])
    previous_employee.company_id == new_employee.company_id
  end
end

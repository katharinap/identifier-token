# frozen_string_literal: true

class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[edit update destroy]
  before_action :set_company, except: %i[update destroy]

  def index
    @employees = @company.employees
  end

  def new
    @employee = @company.employees.build
    @companies = Company.all
  end

  def edit
    @companies = Company.all
  end

  def create
    @employee = @company.employees.build(employee_params)

    if @employee.save
      # rubocop:disable Metrics/LineLength
      redirect_to company_employees_path(@company), notice: 'Employee was successfully created.'
    # rubocop:enable Metrics/LineLength
    else
      render :new
    end
  end

  def update
    if @employee.update(employee_params)
      # rubocop:disable Metrics/LineLength
      redirect_to company_employees_path(@employee.company), notice: 'Employee was successfully updated.'
    # rubocop:enable Metrics/LineLength
    else
      render :edit
    end
  end

  def destroy
    # rubocop:disable Metrics/LineLength
    if @employee.allow_destroy?
      @employee.destroy
      redirect_to company_employees_path(@employee.company), notice: 'Employee was successfully destroyed.'
    else
      redirect_to company_employees_path(@employee.company), alert: 'Cannot destroy employee with assigned clients.'
    end
    # rubocop:enable Metrics/LineLength
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def set_company
    # rubocop:disable Metrics/LineLength
    @company = params[:company_id] ? Company.find(params[:company_id]) : @employee.company
    # rubocop:enable Metrics/LineLength
  end

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :company_id)
  end
end

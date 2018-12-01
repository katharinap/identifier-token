# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[edit update destroy]
  before_action :set_employee, except: %i[index update destroy]

  def index
    if params[:company_id]
      @company = Company.includes(employees: :clients).find(params[:company_id])
      @clients = @company.employees.map(&:clients).flatten
      render :index_company
    else
      set_employee
      @company = @employee.company
      @clients = @employee.clients.sort_by(&:full_name)
    end
  end

  def new
    @client = @employee.clients.build
  end

  def edit; end

  def create
    @client = @employee.clients.build(client_params)

    if @client.save
      # rubocop:disable Metrics/LineLength
      redirect_to employee_clients_path(@employee), notice: 'Client was successfully created.'
    # rubocop:enable Metrics/LineLength
    else
      render :new
    end
  end

  def update
    if @client.update(client_params)
      # rubocop:disable Metrics/LineLength
      redirect_to employee_clients_path(@client.employee), notice: 'Client was successfully updated.'
    # rubocop:enable Metrics/LineLength
    else
      render :edit
    end
  end

  def destroy
    @client.destroy
    # rubocop:disable Metrics/LineLength
    redirect_to employee_clients_path(@client.employee), notice: 'Client was successfully destroyed.'
    # rubocop:enable Metrics/LineLength
  end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def set_employee
    # rubocop:disable Metrics/LineLength
    @employee = params[:employee_id] ? Employee.find(params[:employee_id]) : @client.employee
    # rubocop:enable Metrics/LineLength
  end

  def client_params
    params.require(:client).permit(:first_name, :last_name)
  end
end

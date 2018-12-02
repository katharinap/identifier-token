# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[edit update destroy]

  def index
    if params[:company_id]
      @company = Company.find(params[:company_id])
      @clients = @company.clients
      @employee = @company.employees.first
    else
      @employee = Employee.find(params[:employee_id])
      @company = @employee.company
      @clients = @employee.clients
    end
  end

  def new
    @employee = Employee.find(params[:employee_id])
    @client = @employee.clients.build
    @company_employees = @employee.co_workers(include_self: true)
  end

  def edit
    @employee = @client.employee
    @company_employees = @employee.co_workers(include_self: true)
  end

  def create
    @client = Client.new(client_params)
    @employee = @client.employee

    if @client.save
      # rubocop:disable Metrics/LineLength
      redirect_to employee_clients_path(@employee), notice: 'Client was successfully created.'
    # rubocop:enable Metrics/LineLength
    else
      render :new
    end
  end

  def update
    UpdatesClient.new(@client, client_params)
    # rubocop:disable Metrics/LineLength
    redirect_to employee_clients_path(@client.employee), notice: 'Client was successfully updated.'
    # rubocop:enable Metrics/LineLength
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

  def client_params
    params.require(:client).permit(:first_name, :last_name, :employee_id)
  end
end

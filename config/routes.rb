# frozen_string_literal: true

Rails.application.routes.draw do
  resources :companies, except: %i[show] do
    resources :employees, shallow: true, except: %i[show]
  end

  root to: 'companies#index'
end

# frozen_string_literal: true

Rails.application.routes.draw do
  resources :companies, shallow: true, except: %i[show] do
    resources :clients, only: %i[index]
    resources :employees, except: %i[show] do
      resources :clients, except: %i[show]
    end
  end

  root to: 'companies#index'
end

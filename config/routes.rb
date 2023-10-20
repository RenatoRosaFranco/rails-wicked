# frozen_string_literal: true

Rails.application.routes.draw do
  
  # Root
  root to: 'signup#index'

  # Users
  resources :products, only: [:new, :show, :create] do
    resources :build, only: [:create, :show, :update], controller: 'products/build'
  end
end

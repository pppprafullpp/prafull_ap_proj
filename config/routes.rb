Rails.application.routes.draw do
  resources :campaigns
  resources :categories
  devise_for :advertisers, :controllers => { registrations: 'advertisers' }

  resources :advertisers do
    get :accounts
  end

  resources :influencers

  root 'home#index'

end

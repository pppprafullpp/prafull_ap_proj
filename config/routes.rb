Rails.application.routes.draw do
  resources :campaigns
  resources :categories
  devise_for :advertisers, :controllers => { registrations: 'advertisers' }

  resources :advertisers do
    get :accounts
    get :ad_requests
    get :insights
    get :setting
    get :payments
  end

  resources :influencers

  root 'home#index'

end

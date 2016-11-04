Rails.application.routes.draw do
  resources :campaigns
  resources :categories
  devise_for :advertisers, :controllers => { registrations: 'advertisers' }

  resources :advertisers do
    get :social_accounts
    get :ad_requests
    get :audience_management
    get :setting
    get :payments
    get :ad_compaigns
    get :create_ad_compaign
  end

  resources :influencers

  root 'home#index'

end

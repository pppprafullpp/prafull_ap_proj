Rails.application.routes.draw do
  devise_for :admins
  resources :admins 
  resources :campaigns
  resources :categories
  resources :advertisments
  devise_for :advertisers, :controllers => { registrations: 'registrations', passwords: "advertisers/change_password" }
  devise_for :influencers, :controllers => { registrations: 'registrations', passwords: "advertisers/change_password" }

  resources :registrations do
    post :sign_up
  end

  resources :advertisers do
    get :social_accounts
    get :ad_requests
    get :audience_management
    get :setting
    get :payments
    get :ad_compaigns
    get :create_ad_compaign
    post :change_password
    get :influencer_detail
  end

  resources :influencers do
    get :social_accounts
    get :ad_requests
    get :audience_management
    get :setting
    get :payments
    get :ad_requests
    get :create_ad_compaign
    post :change_password
    post :add_social_account_details
    end


  root 'home#index'

end

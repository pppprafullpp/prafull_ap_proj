Rails.application.routes.draw do
  devise_for :admins
  resources :admins
  resources :campaigns
  resources :categories

  resources :advertisments do
    post :update_ad_share_url_and_status
    collection do
      post :ad_declined_by_influencer
    end
  end

  devise_for :advertisers, :controllers => { registrations: 'registrations', passwords: "advertisers/change_password" }
  devise_for :influencers, :controllers => { registrations: 'registrations', passwords: "advertisers/change_password" }

  resources :registrations do
    post :sign_up
  end

  get "/activate" => "home#activate"

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
    get :profile
    get :my_wallet
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
    get :profile
    get :ad_history
    end


  root 'home#index'

end

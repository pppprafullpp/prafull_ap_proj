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
  post "/update_influencer_profile_photo" =>"influencers#update_influencer_profile_photo"
  post "/update_advertiser_profile_photo" =>"advertisers#update_advertiser_profile_photo"

  devise_for :advertisers, :controllers => { registrations: 'registrations', passwords: 'passwords' }
  devise_for :influencers, :controllers => { registrations: 'registrations', passwords: 'passwords' }

  resources :wallets do
    collection do
      match :init_transaction, :via => [:post]
    end
  end
  get "/capture_transaction" => "wallets#init_transaction"
  resources :passwords do
    collection do
      post :change_password
    end
  end
  resources :registrations do
    post :sign_up
  end
  post "/check_existing_user" => "registrations#check_existing_user"
  post "/get_messages" => "messages#get_messages"
  get "/activate" => "home#activate"
  match "/get_pending_notification" => "notifications#get_pending_notification", :via=>["post"]
  match "/reset_pending_notification" => "notifications#reset_pending_notification", :via=>["post"]
  post "/check_email_existing" => "home#check_email_existing"
  resources :messages

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
    get :show_influencers
    get :profile
    get :my_wallet
    collection do
      post :get_wallet_status
      get :show_influencer_details
      post :create_audience_group
      post :destroy_group
      get :group_details
      post :delete_group_member
      post :check_existing_group
    end
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


  root 'registrations#new'

end

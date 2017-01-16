class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :declined_by_influencer, :approved_by_admin
  require 'pusher'

  pusher_client = Pusher::Client.new(
   app_id: '279343',
   key: '8a6db1144940a1e554b7',
   secret: '6b169a384f2be024c463',
   encrypted: true
 )

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def notify_admin
    flash[:success] = "New Advertisement created"
  end
  def generate_activation_token
    a = ('a'..'z').to_a.shuffle.first(10).join
    b = ('0'..'9').to_a.shuffle.first(10).join
    token = a + b
    token
  end

  def declined_by_influencer
    value = Advertisement::STATUS["Declined by influencer"]
    value
  end

  def approved_by_admin
    value = Advertisement::STATUS["Approved by Admin"]
    value
  end

  def add_notification(type,activity,viewed=falsel)
    Notification.create!(:activity_type=>type,:activity=>activity,:viewed=>viewed)
    puts "Notification added"
  end

  def today_earning(type,id)
    amount = Transaction.where("created_at >= ? and #{type}_id = ?", Time.zone.now.beginning_of_day,id).sum(:amount)
    amount
  end

  def monthly_earning(type,id)
    amount = Transaction.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month,eval(":#{type}_id")=>id).sum(:amount)
    amount
  end


  def spent_today(type,id)
    amount = Transaction.where("created_at >= ? and #{type}_id = ?", Time.zone.now.beginning_of_day,id).sum(:amount)
    amount
  end

  def spent_monthly(type,id)
    amount = Transaction.where(created_at: Time.now.beginning_of_month..Time.now.end_of_month,eval(":#{type}_id")=>id).sum(:amount)
    amount
  end

  def published_ad_count(advertiser_id)
    published_ads = Advertisement.where(:status=>6,:advertiser_id=>advertiser_id).count
    published_ads
  end

  def published_by_influencer_count(influencer_id)
    published_ads_count = Advertisement.where(:status=>6,:influencer_id=>influencer_id).count
    published_ads_count
  end

  def uncoming_ads(influencer_id)
    uncoming_ads_count = Advertisement.where(:status=>1,:influencer_id=>influencer_id).count
    uncoming_ads_count
  end


end

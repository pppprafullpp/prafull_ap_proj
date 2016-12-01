require "fb_graph2"

namespace :update_social_data do
    task :update_facebook_likes,[:access_token] => :environment do |t,token|
      puts DateTime.now
      social_accounts = SocialAccount.all
        social_accounts.each do |social_account|
          page = FbGraph2::Page.new(social_account.platform_type_id).fetch(
                :access_token => "986978254757512|vGvEynp44LE_I_yG6dgAsjlF770",
                :fields => [:fan_count, :about,:picture,:location,:category]
                )
                puts "Updated:#{social_account.platform_type_id} with #{page.raw_attributes['fan_count'].to_s} likes"
                country = page.raw_attributes["location"].present? ? page.raw_attributes["location"]["country"] : "Not provided"
                category = page.raw_attributes["category"].present? ? page.raw_attributes["category"] : "Not Provided"
                social_account.update_attributes(
                :facebook_page_count => page.raw_attributes['fan_count'].to_s,
                :about => page.raw_attributes['about'],
                :facebook_image_url=>page.raw_attributes["picture"]["data"]["url"],
                :country => country,
                :category => page.raw_attributes["category"]
)
          end
          puts "--------------------------------------------------------------------------------------"
      end

    end

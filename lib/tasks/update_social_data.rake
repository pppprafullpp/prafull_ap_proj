require "fb_graph2"

namespace :update_social_data do
    task :update_facebook_likes,[:access_token] => :environment do |t,token|
      social_accounts = SocialAccount.all
        social_accounts.each do |social_account|
          page = FbGraph2::Page.new(social_account.platform_type_id).fetch(
                :access_token => "986978254757512|vGvEynp44LE_I_yG6dgAsjlF770",
                :fields => [:fan_count, :about]
                )
                puts "Updated:#{social_account.platform_type_id} with #{page.raw_attributes['fan_count'].to_s} likes"
                social_account.update_attributes(:facebook_page_count => page.raw_attributes['fan_count'].to_s,:about => page.raw_attributes['about'])
          end
      end
    end

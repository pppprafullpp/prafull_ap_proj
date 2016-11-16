require "fb_graph2"

namespace :update_social_data do
    task update_facebook_likes: :environment do
      all_influencers = Influencer.all
      all_influencers.each do |influencer|
        if influencer.social_account.present?
              # influnencer_social_accounts.each do |influencer_social_account|
                page = FbGraph2::Page.new(influencer.social_account.platform_type_id).fetch(
                    :access_token => "EAACEdEose0cBADsDLXI2ZAF49W5L8NAukK9JPMmnbpZCPIvtT1nkKxjWwIkZBhUcgYJaNgsQZAGq2KjHZCYNXeOVZBpQqGAgsPxb0iZAxoS6ZClXaUOmdwEJFwsaHUKprflZB5p6FVCZCcfxBaAMx3Ja7JZBgBAqIk2rabtbAbmB5U0bcEKl8cZANxNQ"
                    )
                    influencer.social_account.update_attributes(:facebook_page_count => page.likes.to_s)
                    puts influencer.social_account.platform_type_id + ":" + page.likes.to_s
              # end
          end
        end
      end
    end

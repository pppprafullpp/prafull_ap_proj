require "fb_graph2"

namespace :update_social_data do
    task update_facebook_likes: :environment do
      all_influencers = Influencer.all
      all_influencers.each do |influencer|
        if influencer.social_account.present?
              # influnencer_social_accounts.each do |influencer_social_account|
                page = FbGraph2::Page.new(influencer.social_account.platform_type_id).fetch(
                    :access_token => "EAACEdEose0cBANuqFcKNMY9vhX5GvuEWyiWDZBZBopIOx1QfOVJYCZBpd8JJTcbThA0N9BDmACekHbbsAKwMxb5ce0KMBd2iGoCurpharqCgdqOUI37JuZBOKOt9cLq2FbGZAouTZAKQCw7GrliI3Tc5OgG3VfSkriJ1MPjofXUl7DpppS4ZAJZC"
                    )
                    influencer.social_account.update_attributes(:facebook_page_count => page.likes.to_s)
                    puts influencer.social_account.platform_type_id + ":" + page.likes.to_s
              # end
          end
        end
      end
    end

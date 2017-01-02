require "fb_graph2"

namespace :update_social_data do
    task :update_facebook_likes => :environment do |t,token|
      social_accounts = SocialAccount.all
        social_accounts.each do |social_account|
          page = FbGraph2::Page.new(social_account.facebook_page_id).fetch(
                :access_token => "986978254757512|vGvEynp44LE_I_yG6dgAsjlF770",
                :fields => [:fan_count, :about,:picture,:location,:category]
                )
                puts "Updated:#{social_account.facebook_page_id} with #{page.raw_attributes['fan_count'].to_s} likes"
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

      task add_facebook_dummy_data: :environment do
          a = ["BBkiVines", "ServiceDealz", "softwareassurance", "isuportNamo", "AmitabhBachchan", "CharlieChaplinOfficial/", "akshaykumarofficial", "akshaykumarofficial", "BeingSalmanKhan", "BeingSalmanKhan", "AsliJacquelineFernandez", "officialtomcruise", "VinDiesel", "Angelina-Jolie", "KatrinaKaif", "TaylorSwift", "shakira", "Justin.Bieber.II", "michaeljackson", "barackobama", "narendramodi", "DonaldTrump", "McDonalds", "pizzahutindia", "Dominos", "cadburycelebrations", "PeterDinklage", "BeingSalmanKhan"]
          SocialAccount.all.each_with_index do |sa,index|
            puts sa.facebook_page_id
            value = a[0] if !a[index].present?
            sa.update_attributes(:facebook_page_id=>a[index])
          end
      end


    end

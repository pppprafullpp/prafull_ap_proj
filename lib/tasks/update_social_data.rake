require "fb_graph2"

namespace :update_social_data do
    task :update_facebook_likes => :environment do |t,token|
      social_accounts = SocialAccount.all
        social_accounts.each do |social_account|
          puts "id="+social_account.id.to_s
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

      task add_facebook_insights: :environment do
        facebook_page_ids = SocialAccount.pluck(:facebook_page_id)
        graph = Koala::Facebook::API.new("EAAOBpshGnogBAIZBo8yVpqwsjHZCv4TCbzE8LvaOJdVDwZAqARfFZBSP3yBI7q3Cn3HyMVZBf46dBl7PeO4amEkzVPC1ZBLYTWhMdtVwYwjMZBcmCZBLtZBvifFIIY6i6K7hl0teDcoeLlFjzIc9KNM2aivm3ZBVbbmvcJV46fPNCJbwZDZD")

        page_consumptions = graph.get_connections("882472861843543","/insights/page_consumptions")
        page_consumptions_by_consumption_type = graph.get_connections("882472861843543","/insights/page_consumptions_by_consumption_type")
        page_fans = graph.get_connections("882472861843543","/insights/page_fans")
        page_fans_locale = graph.get_connections("882472861843543","/insights/page_fans_locale")
        page_views_total = graph.get_connections("882472861843543","/insights/page_views_total")
        page_fans_gender_age = graph.get_connections("882472861843543","/insights/page_fans_gender_age")
        puts "consumptions="+page_consumptions[2]["values"][2]["value"].to_s
        puts "fans="+page_fans[0]["values"][0]["value"].to_s
        puts "page_fans_locale"+page_fans_locale[0]["values"][0]["value"].to_s
        puts "page views total"+page_views_total.to_s
      end
    end

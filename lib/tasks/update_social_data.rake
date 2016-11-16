require "fb_graph2"

namespace :update_social_data do
    task :update_facebook_likes,[:access_token] => :environment do |t,token|
      auth = FbGraph2::Auth.new("986978254757512", "d3bd80666756be8503c2b0aff0277718")
      token_obj = auth.debug_token! 'obtained-access-token'
      access_token = token_obj.access_token.access_token
      social_accounts = SocialAccount.all
        social_accounts.each do |social_account|
          page = FbGraph2::Page.new(social_account.platform_type_id).fetch(
                :access_token => access_token,
                )
                puts "Updated:#{social_account.platform_type_id}"
                social_account.update_attributes(:facebook_page_count => page.likes.to_s,:about => page.about)
          end
      end
    end

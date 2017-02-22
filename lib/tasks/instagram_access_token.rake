require "fb_graph2"
require 'rest-client'

namespace :instagram_access_token do
    task :update_instagram_access_token => :environment do
    d =  sh("curl -F 'client_id=6b7aae8b938642eeb242a76096727fdf' \
           -F 'client_secret=3c43a98952704522a1077dcd8cb1ce7f' \
           -F 'grant_type=authorization_code' \
           -F 'redirect_uri=http://localhost:3000' \
           -F 'code=782f1becd8134588b03060539ffc8c20Q' \
          https://api.instagram.com/oauth/access_token")
          puts d
    end
  end

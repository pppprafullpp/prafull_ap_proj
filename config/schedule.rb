# require "./"+ File.dirname(__FILE__) + "/environment.rb"
#
# set :output, { error: 'error.log', standard: 'cron.log' }
#
# app_configuration_for_update_social_data = AppConfiguration.find_by(:config_key=>"update_social_data").config_value.to_i
#
# every app_configuration_for_update_social_data.hours do
#     rake "update_social_data:update_facebook_likes"
# end

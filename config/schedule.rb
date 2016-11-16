# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
every 2.hours do
    rake "update_social_data:update_facebook_likes['EAACEdEose0cBAA2DxYHlyY2ZBL5AZC56FYU1rduSuvk3CSsFRZCAsXpCtUtur3napb1b9xJZCuy4Lx4lGZA8q8RVZCmRYeSHi9aINrVLcihmOiLUyQ788zhVLIwfgcc04XIHEKlCsdt7mWnoYAJJlilXpWGXgDW6uojydJNysunDT23vdOsRl6']"
end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# auth = FbGraph2::Auth.new(FACEBOOK_APP_ID, FACEBOOK_APP_SECRET)

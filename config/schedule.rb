# File created 10/05/2019 by David Wing
# Edited 10/06/2019 by David Wing
# Use this file to easily define all of your cron jobs.

require 'json'
require_relative "../info_scrape"
require_relative "../caching"

time = Time.new

# Log file for cron job
set :output, "cron_log/"+time.day.to_s+"-"+time.month.to_s+".log"

# Refresh cache content
every 1.day do
    cache_all_pages
end


# check user preferences to get timing for email

# For each user pref file
user_file = File.read("user_information/user_data.json")
data = JSON.parse(user_file)

data.keys.each do |user|
    
    timing = 1.minute
    # case user["subscription"]
    # when "daily"    
    #     timing = 1.day
    # when "weekly"
    #     timing = 1.week
    # when "monthly"
    #     timing = 1.months
    # end    

    every timing do 

        
        all_schedules_and_news = all_sports_schedules_and_news
        schedules = all_schedules_and_news[:schedules]
        news_info = all_schedules_and_news[:news]
        puts user['email']

        runner "user.send_email(news_info, schedules, \"osusportsdigest@gmail.com\")"
    end

end            

# def send_email(news_info, schedules, gmail)


#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

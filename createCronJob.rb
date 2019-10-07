# File created 10/05/2019 by David Wing
# Edited 10/06/2019 by David Wing
# Use this file to easily define all of your cron jobs.

require 'json'
require "google/apis/gmail_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "mail"
require_relative "info_scrape"
require_relative "caching"
require_relative 'user'
require_relative 'get_compiled_info'



# Constants used to authenticate our use of google's api
OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
APPLICATION_NAME = "Google Docs API Ruby Quickstart".freeze
CREDENTIALS_PATH = "credentials.json".freeze
TOKEN_PATH = "token.yaml".freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_COMPOSE

time = Time.new

# Log file for cron job
# set :output, "cron_log/"+time.day.to_s+"-"+time.month.to_s+".log"



cache_all_pages

all_schedules_and_news = all_sports_schedules_and_news
schedules = all_schedules_and_news[:schedules]
news_info = all_schedules_and_news[:news]

# Client authorization to use google api
client = Google::Apis::GmailV1::GmailService.new
client.authorization = authorize


# check user preferences to get timing for email

# For each user pref file
users = JSON.parse File.read "user_information/user_data.json"
users.each do |user_json|
    

    user_json.each do |user_info|
        
        next if !user_info['email']
        next if !user_info['subscription'] 

        system("crontab -l > mycron")

        case user_info["subscription"]
        when "daily"    
            system("echo \"MAILTO=\""+user_info['email']+ "\"\n0 0 12 * * ? ruby createCronJob.rb\" >>mycron")
        when "weekly"
            system("echo \"MAILTO=\""+user_info['email']+ "\"\n0 0 12 * * SAT ruby createCronJob.rb\" >>mycron")
        when "monthly"
            system("echo \"MAILTO=\""+user_info['email']+ "\"\n0 0 12 1 * ? ruby createCronJob.rb\" >>mycron")
        end    

        system("crontab mycron")
        system("rm mycron")

        # puts user_info["email"]
        # puts user_info['info']
        # puts user_info['sports']
        # puts user_info['subscription']
        curr_user = User.new( user_json[0] ,user_info['email'], user_info['sports'], user_info['info'], user_info['subscription'])
        

        # puts curr_user.info
        
        curr_user.send_email(news_info, schedules, client)




    end


end            


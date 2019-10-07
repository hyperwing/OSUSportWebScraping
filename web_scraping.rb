# Created 09/24/2019 by Leah Gillespie
# Edited 09/25/2019 by Sharon Qiu
# Edited 09/25/2019 by Neel Mansukhani
# Edited 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani
# Edited 09/28/2019 by Sri Ramya Dandu
# Edited 09/29/2019 by Sri Ramya Dandu
# Edited 10/02/2019 by Sharon Qiu
# Edited 10/04/2019 by Sri Ramya Dandu
# Edited 10/05/2019 by Sri Ramya Dandu
# Edited 10/05/2019 by Sharon Qiu
# Edited 10/05/2019 by Neel Mansukhani
# Edited 10/06/2019 by David Wing

# Main logic for Project
# Project Description: This program scrapes the following website
# https://ohiostatebuckeyes.com/bucks-on-us/. 
# This website provides infromation about all the sports with free parking, free admission, free fun.
require 'time'
require 'net/smtp'
require 'json'
require "google/apis/gmail_v1"
require "googleauth"
require "googleauth/stores/file_token_store"
require "mail"
require_relative 'utilities'
require_relative 'cache/info_scrape'
require_relative 'get_compiled_info'
require_relative 'user'
require_relative 'past_season_scrape'

# Constants used to authenticate our use of google's api
OOB_URI = "urn:ietf:wg:oauth:2.0:oob".freeze
APPLICATION_NAME = "Google Docs API Ruby Quickstart".freeze
CREDENTIALS_PATH = "credentials.json".freeze
TOKEN_PATH = "token.yaml".freeze
SCOPE = Google::Apis::GmailV1::AUTH_GMAIL_COMPOSE

# Created 09/24/2019 by Leah Gillespie
# Edited 09/25/2019 by Neel Mansukhani: Added if __FILE__ to use functions in different files.
# Edited 09/26/2019 by Leah Gillespie: Updated to work with news.
# Edited 09/26/2019 by Neel Mansukhani: Added user preferences for emails and input validation.
# Edited 10/02/2019 by Sharon Qiu: added time check
# Edited 10/04/2019 by Sri Ramya Dandu: Modified input and factored into functions
# Edited 10/05/2019 by Sri Ramya Dandu: Fixed case issues
# Edited 10/05/2019 by Sharon Qiu: Implemented news query search.
# Edited 10/05/2019 by Neel Mansukhani: Removed if __FILE__
# Edited 10/06/2019 by Leah Gillespie: added I/O for past seasons
# Edited 10/06/2019 by David Wing: mapped sports to url names
# ============================================================================
# 'Main' method, gather info, interacts with user
puts "Gathering information..."
start = Time.now
# Client authorization to use google api
client = Google::Apis::GmailV1::GmailService.new
client.authorization = authorize

all_schedules_and_news = all_sports_schedules_and_news
schedules = all_schedules_and_news[:schedules]
news_info = all_schedules_and_news[:news]
schedules.each {|item| puts item.sport}
# Net::SMTP.start 'mail.google.com', 25,'127.0.0.1','osusportsdigest','403SleepForbidden'
ending = Time.now
puts "Finished gathering information. Time taken: #{ending-start} seconds."
sports_reg_ex = sport_reg_exp schedules
print "Please enter a username: "
username = gets.chomp
if is_used_username? username
  puts "Welcome back #{username}!"
  users = JSON.load File.new 'user_information/user_data.json'
  user = User.new username, users[username]['email'], users[username]['sports'], users[username]['info'], users[username]['subscription']
  user.remove_user_from_json if (yes_no_input "Would you like to unsubscribe? (Y/N):") == "Y"
elsif (yes_no_input "Would you like to receive emails? (Y/N):") == "Y"
  user = User.get_user_preferences sports_reg_ex, username
  user.send_email news_info, schedules, client
  puts 'Email Successfully Sent'
end
puts "Below you can get information on sports."
list_sports sports_reg_ex
continue = "Y"

# While user wants more info
while continue == "Y"
  sport = get_sport_choice sports_reg_ex
  s_n_b = "" # TODO refactor
  while s_n_b != "schedule" && s_n_b != "news" && s_n_b != "both"
    print "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both: "
    s_n_b = gets.chomp.downcase
  end

  # display info based on user choice
  case s_n_b
  when "schedule"
    schedule = get_schedule sport, schedules
    schedule.display nil
  when "news"
    kw = get_search_keywords
    news = get_news sport, news_info
    news.display kw
  when "both"
    kw = get_search_keywords
    schedule = get_schedule sport, schedules
    schedule.display nil
    news = get_news sport, news_info
    news.display kw
  when "past"

    # Map the sport into url for the season
    sport_map = {
      "Cross Country, Men's" => "m-xc", "Cross Country, Women's" => "w-xc",
      "Golf, Men's" => "m-golf", "Golf, Women's" =>"w-golf",
      "Fencing"=> "x-fenc",
      "Field Hockey"=>"w-fieldh","Ice Hockey, Women" => "w-hockey",
      "Gymnastics, Men's" => "m-gym",
      "Lacrosse, Women's" => "w-lacros",
      "Pistol" => "c-pistol", "Rifle" => "c-rifle",
      "Rowing" => "w-rowing",
      "Soccer, Men's" => "m-soccer", "Soccer, Women's" => "w-soccer",
      "Softball" => "w-softbl",
      "Swimming & Diving, Men's" => "m-swim", "Swimming & Diving, Women's" => "w-swim", "Synchronized Swimming" => "w-syncs",
      "Tennis, Men's" => "m-tennis","Tennis, Women's" => "w-tennis",
      "Track & Field, Men's" => "m-track", "Track & Field, Women's" => "w-track",
      "Volleyball, Men's" => "m-volley"
    }
    
    year = get_year
    stats = Season.new sport_map[sport], year
    get_stats stats
  end
  continue = yes_no_input "Would you like more information? (Y/N):"
end
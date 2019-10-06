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

# TODO: Documentation for all functions
require 'time'
require 'net/smtp'
require 'json'
require 'gmail'
require_relative 'utilities'
require_relative 'info_scrape'
require_relative 'get_compiled_info'
require_relative 'user'


# TODO: Move functions to other file
# TODO: all gets to upper case

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
puts "Gathering information..."
start = Time.now
cache_all_pages
all_schedules_and_news = all_sports_schedules_and_news
schedules = all_schedules_and_news[:schedules]
news_info = all_schedules_and_news[:news]
gmail = Gmail.connect("osusportsdigest", "403SleepForbidden")
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
  user.send_email news_info, schedules, gmail
  puts 'Email Successfully Sent'
end
puts "Below you can get information on sports."
list_sports sports_reg_ex
continue = "Y"
while continue == "Y"
  sport = get_sport_choice sports_reg_ex
  s_n_b = ""
  while s_n_b != "schedule" && s_n_b != "news" && s_n_b != "both" && s_n_b != "past"
    print "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both, or enter 'Past' for statistics from a prior year: "
    s_n_b = gets.chomp.downcase
  end
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
    year = get_year
    stats = Season.new sport, year
    get_stats stats
  end
  continue = yes_no_input "Would you like more information? (Y/N):"
end

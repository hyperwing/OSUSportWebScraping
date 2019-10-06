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

ending = Time.now
puts "Finished gathering information. Time taken: #{ending-start} seconds."

continue = "Y"
sports_reg_ex = sport_reg_exp schedules
list_sports sports_reg_ex

while continue == "Y"

  if (yes_no_input "Would you like to receive emails? (Y/N):") == "Y"
    user = User.get_user_preferences sports_reg_ex
    user.create_email news_info, schedules
    puts 'Email Successfully Created'
  end
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

# Created 09/24/2019 by Leah Gillespie
# Edited 09/25/2019 by Sharon Qiu
# Edited 09/25/2019 by Neel Mansukhani
# Edited 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani
# Edited 09/28/2019 by Sri Ramya Dandu
# Edited 09/29/2019 by Sri Ramya Dandu
# Edited 10/04/2019 by Sri Ramya Dandu
# Edited 10/05/2019 by Sri Ramya Dandu

# TODO: Documentation for all functions
require_relative 'info_scrape'
require_relative 'user'
require_relative 'utilities'
# TODO:  Rename this file
# TODO: Move functions to other file
# TODO: all gets to upper case


# Created 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani: Returns sport schedule instead of printing
def get_schedule(sport, all_schedules)
  all_schedules[0].each do |current|
    return current if current.sport == sport
  end
end

# Created 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani: Returns sport news instead of printing
def get_news(sport, all_news)
  all_news[1].each do |current|
    return current if current.sport == sport
  end
end

# TODO: Make class method of user?
# Created 09/26/2019 by Neel Mansukhani
# Edited 10/04/2019 by Sri Ramya Dandu: Factored input to functions
# Edited 10/05/2019 by Sri Ramya Dandu: Fixed case issues
# Gets user info and creates file containing email contents
def get_user_preferences(sports_reg_ex)
  print "Please enter a username: "
  username = gets.chomp # TODO: Check if username already exists and don't ask for email on return of user
  print "Please enter a valid email address: "
  email = gets.chomp
  while !isValidEmail? email # TODO: Create Regex in utilities
    puts "Please enter a valid email address: "
    email = gets.chomp
  end
  # TODO: Add how often they want emails
  yes_no = "Y"
  sports = []
  while yes_no == "Y"

    # TODO: Add display list of sports.
    # TODO: Add error msg.
    sports.push(get_sport_choice sports_reg_ex)
    yes_no = yes_no_input "Would you like to add another sport? (Y/N): "
  end
  s_n_b = ""
  while s_n_b != "schedule" && s_n_b != "news" && s_n_b != "both"
    print "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both: "
    s_n_b = gets.chomp.downcase
  end
  info = []
  case s_n_b
  when "schedule"
    info.push"Schedule"
  when "news"
    info.push"News"
  when "both"
    info.push"Schedule"
    info.push"News"
  end
  User.new username, email, sports, info
end

# Created 09/24/2019 by Leah Gillespie
# Edited 09/25/2019 by Neel Mansukhani: Added if __FILE__ to use functions in different files.
# Edited 09/26/2019 by Leah Gillespie: Updated to work with news.
# Edited 09/26/2019 by Neel Mansukhani: Added user preferences for emails and input validation.
# Edited 10/04/2019 by Sri Ramya Dandu: Modified input and factored into functions
# Edited 10/05/2019 by Sri Ramya Dandu: Fixed case issues
if __FILE__ == $0
  all_schedules_and_news = all_sports_schedules_and_news
  continue = "Y"
  sports_reg_ex = sport_reg_exp all_schedules_and_news
  list_sports sports_reg_ex

  while continue == "Y"

    if (yes_no_input "Would you like to receive emails? (Y/N):") == "Y"
      user = get_user_preferences sports_reg_ex
      user.create_email all_schedules_and_news
      puts 'Email Successfully Created'
    end
    sport = get_sport_choice sports_reg_ex
    s_n_b = ""
    while s_n_b != "schedule" && s_n_b != "news" && s_n_b != "both"
      print "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both: "
      s_n_b = gets.chomp.downcase
    end
    case s_n_b
    when "schedule"
      schedule = get_schedule sport, all_schedules_and_news
      schedule.display nil
    when "news"
      news = get_news sport, all_schedules_and_news
      news.display nil
    when "both"
      schedule = get_schedule sport, all_schedules_and_news
      schedule.display nil
      news = get_news sport, all_schedules_and_news
      news.display nil
    end
    continue = yes_no_input "Would you like more information? (Y/N):"
  end
end

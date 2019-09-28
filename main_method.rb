# Created 09/24/2019 by Leah Gillespie
# Edited 09/25/2019 by Sharon Qiu
# Edited 09/25/2019 by Neel Mansukhani
# Edited 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani
# TODO: Documentation for all functions
require_relative 'info_scrape'
require_relative 'user'
require_relative 'utilities'
# TODO:  Rename this file
# TODO: Move functions to other file
# TODO: all gets to upper case
# TODO: add autocorrect

# TODO: terse code function name
# Created 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani: Returns sport schedule instead of printing
def getSchedule(sport, all_schedules)
  all_schedules[0].each do |current|
      return current if current.sport == sport
  end
end

# TODO: terse code function name
# Created 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani: Returns sport news instead of printing
def getNews(sport, all_news)
  all_news[1].each do |current|
      return current if current.sport == sport
    end
  end
end

# TODO: Make class method of user?
# TODO: terse code function name
# Created 09/26/2019 by Neel Mansukhani
# Gets user info and creates file containing email contents
def getUserPreferences
  puts "Please enter a username: "
  username = gets.chomp # TODO: Check if username already exists and don't ask for email on return of user
  puts "Please enter a valid email address: "
  email = gets.chomp
  while !isValidEmail? email # TODO: Create Regex in utilities
    puts "Please enter a valid email address: "
    email = gets.chomp
  end
  # TODO: Add how often they want emails
  yes_no = "Y"
  sports = []
  while yes_no == "Y"
    # TODO: Move get sport to own function.
    # TODO: Add display list of sports.
    # TODO: Add error msg.
    puts "Please enter the full name of a sport you would like information about: "
    sport = gets.chomp
    while !isValidSport? sport # TODO: Create Regex in utilities
      puts "Not a valid sport, please enter a valid sport: "
      sport = gets.chomp
    end
    sports.push(sport)
    yes_no = ""
    while yes_no != "Y" && yes_no != "N"
      puts "Would you like to add another sport? (Y/N): "
      yes_no = gets.chomp
    end
  end
  s_n_b = ""
  while s_n_b != "Schedule" && s_n_b != "News" && s_n_b != "Both"
    puts "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both."
    s_n_b = gets.chomp
  end
  info = []
  case s_n_b
  when "Schedule"
    info.push"Schedule"
  when "News"
    info.push"News"
  when "Both"
    info.push"Schedule"
    info.push"News"
  end
  User.new username, email, sports, info
end

# Created 09/24/2019 by Leah Gillespie
# Edited 09/25/2019 by Neel Mansukhani: Added if __FILE__ to use functions in different files.
# Edited 09/26/2019 by Leah Gillespie: Updated to work with news.
# Edited 09/26/2019 by Neel Mansukhani: Added user preferences for emails and input validation.
if __FILE__ == $0
  all_schedules_and_news = all_sports_schedules_and_news
  continue = "Y"
  while continue == "Y"
    yes_no = ""
    # TODO: Move y/n to its own function
    while yes_no != "Y" && yes_no != "N"
      puts "Would you like to receive emails? (Y/N)"
      yes_no = gets.chomp
    end
    if yes_no == "Y"
      user = getUserPreferences
      user.createEmail all_schedules_and_news
      puts 'Email Successfully Created'
    end
    puts "What sport would you like to look at? (Please use the full name)"
    sport = gets.chomp
    while !isValidSport? sport
      puts "Not a valid sport, please enter a valid sport: "
      sport = gets.chomp
    end
    s_n_b = ""
    while s_n_b != "Schedule" && s_n_b != "News" && s_n_b != "Both"
      puts "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both."
      s_n_b = gets.chomp
    end
    case s_n_b
    when "Schedule"
      schedule = getSchedule sport, all_schedules_and_news
      schedule.display nil
    when "News"
      news = getNews sport, all_schedules_and_news
      news.display nil
    when "Both"
      schedule = getSchedule sport, all_schedules_and_news
      schedule.display nil
      news = getNews sport, all_schedules_and_news
      news.display nil
    end
    continue = ""
    while continue != "Y" && continue != "N"
      puts "Would you like more information? (Y/N)"
      continue = gets.chomp
    end
  end
end

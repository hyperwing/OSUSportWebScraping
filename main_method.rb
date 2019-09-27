# Created 09/24/2019 by Leah Gillespie
# Edited 09/25/2019 by Sharon Qiu
# Edited 09/25/2019 by Neel Mansukhani
# Edited 09/26/2019 by Neel Mansukhani

require_relative 'info_scrape'
require_relative 'user'
require_relative 'utilities'

# Edited 09/26/2019 by Neel Mansukhani: Returns sport schedule instead of printing
def getSchedule(sport, all_schedules)
  all_schedules.each do |current|
    if current.sport == sport
      return current
    end
  end
end

def getNews(sport, all_news)

end
# Created 09/26/2019 by Neel Mansukhani
# Get's user info and creates file containing email contents
def getUserPreferences
  puts "Please enter a username: "
  username = gets.chomp # TODO: Check if username already exists
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
  s_or_n_or_b = ""
  while s_or_n_or_b != "S" && s_or_n_or_b != "N" && s_or_n_or_b != "B"
    puts "Would you like Schedules, News, or Both for these sports? (S/N/B): "
    s_or_n_or_b = gets.chomp
  end
  info = []
  case s_or_n_or_b
  when "S"
    info.push"Schedule"
  when "N"
    info.push"News"
  when "B"
    info.push"Schedule"
    info.push"News"
  end
  User.new username, email, sports, info
end
# Edited 09/25/2019 by Neel Mansukhani: Added if __FILE__ to use functions in different files.
# Edited 09/26/2019 by Neel Mansukhani: Added user preferences for emails and input validation.
if __FILE__ == $0
  all_schedules_and_news = all_sports_schedules_and_news
  #all_news =
  continue = "Y"
  while continue == "Y"
    yes_no = ""
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
    s_or_n = ""
    while s_or_n != "S" && s_or_n != "N"
      puts "Please enter 'S' for schedule information or 'N' for news."
      s_or_n = gets.chomp
    end
    if s_or_n == "S"
      schedule = getSchedule sport, all_schedules_and_news[0]
      schedule.display nil
    # else
    #   news = getNews sport, all_news
    #   news.display nil
    end
    continue = ""
    while continue != "Y" && continue != "N"
      puts "Would you like more information? (Y/N)"
      continue = gets.chomp
    end
  end
end
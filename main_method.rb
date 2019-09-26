# Created 09/24/2019 by Leah Gillespie
# Edited 09/25/2019 by Sharon Qiu
# Edited 09/26/2019 by Leah Gillespie

require_relative 'info_scrape'

def getSchedule(sport, all_schedules)
  all_schedules.each do |current|
    if current.sport == sport
      current.display
      break
    end
  end
end

# Created 09/26/2019 by Leah Gillespie
def getNews(sport, all_news)
  all_news.each do |current|
    if current.sport == sport
      current.display
    end
  end
end

all_schedules_and_news = all_sports_schedules_and_news
while true
  puts "What sport would you like to look at? (Please use the full name)"
  sport = gets
  sport.chomp!
  puts "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both."
  s_n_b = gets
  s_n_b.chomp!
  if s_n_b == "Schedule" || s_n_b == "Both"
    getSchedule sport, all_schedules_and_news[0]
  end
  if s_n_b == "News" || s_n_b == "Both"
     getNews sport, all_schedules_and_news[1]
  end
  puts "Would you like more information? (Y/N)"
  yes_no = gets
  yes_no.chomp!
  if yes_no != "Y" then break end
end
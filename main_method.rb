# Created 09/24/2019 by Leah Gillespie

require_relative 'info_scrape'

def getSchedule(sport, all_schedules)
  all_schedules.each do |current|
    if current.sport == sport
      current.display
      break
    end
  end
end

def getNews(sport, all_news)
  
end

all_schedules = all_sports_schedules
#all_news =
while true
  puts "What sport would you like to look at? (Please use the full name)"
  sport = gets
  sport.chomp!
  puts "Please enter 'S' for schedule information or 'N' for news."
  s_or_n = gets
  s_or_n.chomp!
  if s_or_n == "S"
    getSchedule sport, all_schedules
  # else
  #   getNews sport, all_news
  end
  puts "Would you like more information? (Y/N)"
  yes_no = gets
  yes_no.chomp!
  if yes_no != "Y" then break end
end
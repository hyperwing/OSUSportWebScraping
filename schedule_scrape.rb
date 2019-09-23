# File created 09/23/2019 by Sri Ramya Dandu
# Obtains the date, opponent, and location info from the following url
# https://ohiostatebuckeyes.com/bucks-on-us/  for each of the free sports

require "mechanize"

# Created 09/23/2019 by Sri Ramya Dandu
# Parses the schedule page of the given sports team and returns an array
#  array[0] = sports team
#  array[n] = [date,team,"home" or "away"]
def parse_schedule(current_page)
  schedule_page = current_page.link_with(href: /schedule/, class: /ohio--home-title-button ohio--base-button/).click

  game_info = Array.new

  #away game schedule
  schedule_page.css('div[class="ohio--schedule-item away_game"]').each do |x|
    date = x.css('div[class="ohio--schedule-date"]').text.strip
    team = x.css('div[class="ohio--schedule-team-name"]').text.strip.gsub(/\t/, '').gsub(/\*/,'')
    game_info.push([date,team,"away"])
  end

  #home game schedule
  schedule_page.css('div[class="ohio--schedule-item home_game"]').each do |x|
    date = x.css('div[class="ohio--schedule-date"]').text.strip
    team = x.css('div[class="ohio--schedule-team-name"]').text.strip.gsub(/\t/, '').gsub(/\*/,'')
    game_info.push([date,team,"home"])
  end
  game_info
end

# Created 09/23/2019 by Sri Ramya Dandu
# Obtains and outputs all the schedules for all the free sports
def all_sports_schedules
  agent = Mechanize.new
  osu_sports_page = agent.get "https://ohiostatebuckeyes.com/bucks-on-us/"

  osu_sports_page.links_with(href: /sports/, class: /ohio-block-links__text/).each do |sport_page_link|
    schedule_page = sport_page_link.click
    all_sports_info = parse_schedule schedule_page
    all_sports_info.unshift schedule_page.css('title').text.strip.gsub(/ – Ohio State Buckeyes/, '')
    print all_sports_info, "\n"
  end
end


all_sports_schedules

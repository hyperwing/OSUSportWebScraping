# File created 09/23/2019 by Sri Ramya Dandu
# Edited 09/24/2019 by Leah Gillespie
# Edited 09/24/2019 by Sharon Qiu
# Edited 09/25/2019 by Sharon Qiu
# Edited 09/26/2019 by Leah Gillespie
# Edited 10/05/2019 by Sharon Qiu
# Edited 10/05/2019 by Sri Ramya Dandu
# Obtains the date, opponent, and location info from the following url.
# Also scrapes news concerning the various sports teams.
# https://ohiostatebuckeyes.com/bucks-on-us/  for each of the free sports

require 'mechanize'
require_relative 'schedule'
require_relative 'news'
require_relative 'caching.rb'


# Created 09/23/2019 by Sri Ramya Dandu
# Parses the schedule page of the given sports team and returns an array
#  array[0] = sports team
#  array[n] = [date,team,"home" or "away"]
def parse_schedule(current_page)
  schedule_page = current_page.link_with(href: /schedule/, class: /ohio--home-title-button ohio--base-button/).click

  game_info = Array.new
  # TODO: awy_game / home_game regex
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
    game_info.push [date,team,"home"]
  end
  game_info
end

# Created 09/23/2019 by Sharon Qiu
# Edited 09/24/2019 by Sharon Qiu: Added in scrape for date, team, title, and URL.
# Scraped info is inclusive and ordered by date, title, and URL of the article. Only scrapes 2019 articles per sport.
# Returns an arrays of articles within an array. Each article array contains:
# [0] = date
# [1] = headline
# [2] = url
def parse_news(webpage)
  # TODO: Explan magic number
  news_page = webpage.links_with(href: /news/, text: /News/)[39].click #index of the specific sport news
  news_articles = Array.new
  current_yr = nil
  prev_yr = nil
  # Parses each news article.
  news_page.css('div[class="sport_news_list__item col-md-4 col-sm-6 col-xs-12"]').each do |value|
    date = value.css('span').text.split
    date = date[0]

    # Only takes in news articles for current year. This is a daily digest, not an archive of information...
    current_yr = date.split('/')[2]
    prev_yr = current_yr if prev_yr == nil
    break if current_yr != prev_yr
    prev_yr = current_yr

    title = value.css('div[class="inner"] > a').text.strip
    url = value.css('div[class="inner"]').css('a')[1]['href']
    news_articles.push [date,title,url]
  end
  
  news_articles
end

# Created 09/23/2019 by Sri Ramya Dandu
# Edited 09/24/2019 by Leah Gillespie: Added use of Schedule class
# Edited 09/24/2019 by Sharon Qiu: modified the loop to also parse news data
# Edited 09/25/2019 by Sharon Qiu: modified the return to return schedules and news in an array where the first element is schedules and the second is news.
# Edited 09/26/2019 by Leah Gillespie: Added use of News class
# Edited 10/05/2019 by Sharon Qiu: modified the return to return schedules and news in a hashmap.
# Edited 10/05/2019 by Sri Ramya Dandu: Fixed issue with wrong '
# Edited 10/06/2019 by Leah Gillespie: Edited to work with cached sites rather than direct access
# Obtains and outputs all the schedules for all the free sports
def all_sports_schedules_and_news
  sports_schedules = Array.new
  sports_news = Array.new
  # For schedule scraping
  $all_sports.each { |team_page|
    sports_schedules.push (Schedule.new team_page.name, parse_schedule(team_page.page))
    sports_news.push (News.new team_page.name, parse_news(team_page.page)) # returns articles without reference to sports team.
  }

  returned_hash = Hash.new{}
  returned_hash[:schedules] = sports_schedules
  returned_hash[:news] = sports_news

  returned_hash
end
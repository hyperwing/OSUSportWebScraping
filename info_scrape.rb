# File created 09/23/2019 by Sri Ramya Dandu
# Edited 09/24/2019 by Sharon Qiu
# Obtains the date, opponent, and location info from the following url.
# Also scrapes news concerning the various sports teams.
# https://ohiostatebuckeyes.com/bucks-on-us/  for each of the free sports

require 'mechanize'
require_relative 'schedule'

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

# Created 09/23/2019 by Sharon Qiu
# Edited 09/24/2019 by Sharon Qiu: Added in scrape for date, team, title, and URL.
# Scraped info is inclusive and ordered by date, title, and URL of the article.
# Returns an array articles and their info in separated array objects.
def parse_news(webpage)
  news_page = webpage.link_with(text: "News").click
  news_articles = Array.new

  #away game schedule
  news_page.css('div[class="sport_news_list__item"]').each do |value|
    date = value.css('span').text.strip
    year = date.split('/')[2]

    # Check to see if it's a news article from this year.
    break if year != "2019"

    title = value.css('div[class="inner"]')[1].text.strip
    url = value.css('div[class="inner"]')['href']
    news_articles.push([title,date,url])
  end
  news_articles
end


# Created 09/23/2019 by Sri Ramya Dandu
# Edited 09/24/2019 by Sharon Qiu: modified the loop to also parse news data
# Obtains and outputs all the schedules for all the free sports
def all_sports_schedules_and_news
  agent = Mechanize.new
  osu_sports_page = agent.get "https://ohiostatebuckeyes.com/bucks-on-us/"
  all_sports_info = Array.new
  sports_news = Hash.new
  # For schedule scraping
  osu_sports_page.links_with(href: /sports/, class: /ohio-block-links__text/).each do |sport_page_link|
    team_name = sport_page_link.text
    team_page = sport_page_link.click
    all_sports_info.push (Schedule.new team_page.css('title').text.strip.gsub(/ – Ohio State Buckeyes/, ''), parse_schedule(team_page))
    sports_news[:team_name] = parse_news team_page
  end

  puts sports_news
  return all_sports_info, sports_news
end
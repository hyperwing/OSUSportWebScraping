# File created 09/23/2019 by Sharon Qiu
# Scrapes news concerning various sports teams.
# Scraped info is inclusive and ordered by date, team, title, and URL of the article.
# News scraped comes from https://ohiostatebuckeyes.com/bucks-on-us/

require "mechanize"

# Created 09/23/2019 by Sharon Qiu
def parse_news(webpage)
    agent = Mechanize.new
    main_page = agent.get "https://ohiostatebuckeyes.com/bucks-on-us/"
    

end

def news_pull

end


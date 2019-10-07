# Created 10/06/2019 by Leah Gillespie
# Stores webpages into cache
require 'mechanize'
require 'open-uri'

# Created 10/06/2019 by Leah Gillespie
# Stores webpage data
class Cache
  attr_accessor :page, :name

  # Created 10/06/2019 by Leah Gillespie 
  def initialize (url, name)
    @agent = Mechanize.new
    @page = @agent.get url
    @name = name
  end
end

# Created 10/06/2019 by Leah Gillespie
# Scrapes webpages for storage
def cache_all_pages
  main_page = Cache.new"https://ohiostatebuckeyes.com/bucks-on-us/", "Home Page"
  file = File.open "cache/list_pages.txt", "w"
  main_page.page.links_with(href: /sports/, class: /ohio-block-links__text/).each do |page_link|
    curr_sport = Cache.new page_link.href, page_link.text.strip
    File.delete "cache/" + curr_sport.name + ".html"
    curr_sport.page.save "cache/" + curr_sport.name + ".html"
    file.puts curr_sport.name + ".html"
  end
  file.close
end
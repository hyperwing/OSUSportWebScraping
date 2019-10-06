#Created 10/06/2019 by Leah Gillespie

require 'mechanize'

# Created 10/06/2019 by Leah Gillespie
class Cache
  attr_accessor :page, :name
  def initialize (url, name)
    @agent = Mechanize.new
    @page = @agent.get url
    @name = name
  end
end

# Created 10/06/2019 by Leah Gillespie
def cache_all_pages
  main_page = Cache.new"https://ohiostatebuckeyes.com/bucks-on-us/", "Home Page"
  $all_sports = Array.new
  main_page.page.links_with(href: /sports/, class: /ohio-block-links__text/).each do |page_link|
    curr_sport = Cache.new page_link.href, page_link.text.strip
    $all_sports.push curr_sport
  end
end
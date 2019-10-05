# File Created 09/25/2019 by Neel Mansukhani

require_relative 'web_scraping'
require_relative 'get_compiled_info'

# Created 09/25/2019 by Neel Mansukhani
class User

  attr_accessor :sports, :info
  # Created 09/25/2019 by Neel Mansukhani
  def initialize(username, email, sports, info)
    @username = username
    @email = email
    @sports = sports
    @info = info
    # TODO: Permanently save user data to json.
  end

  # Created 09/25/2019 by Neel Mansukhani
  # Edited 10/05/2019 by Sharon Qiu: references to news and schedules have been fixed. Also added keywords 
  def create_email(news, schedules)
    user_file = File.open "user_information/#{@username}.txt", 'w'
    user_file.puts @email
    if @info.include? 'News'
      kw = get_search_keywords
      if kw.empty?
        @sports.each do |sport|
          user_file.puts "#{sport} News"
          news = get_news sport, news
          news.display nil, user_file
        end
      else
        @sports.each do |sport|
          user_file.puts "#{sport} News"
          news = get_news sport, news
          news.display kw, user_file
        end
      end
    end
    if @info.include? 'Schedule'
      @sports.each do |sport|
        user_file.puts "#{sport} Schedule"
        schedule = get_schedule sport, schedules
        schedule.display user_file
      end
    end
    user_file.close
  end
end

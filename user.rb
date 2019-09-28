# File Created 09/25/2019 by Neel Mansukhani

require_relative 'main_method'

# Created 09/25/2019 by Neel Mansukhani
class User

  attr_accessor :sports, :info
  # Created 09/25/2019 by Neel Mansukhani
  def initialize(username, email, sports, info)
    # TODO: unparallel this for consistency.
    @username, @email, @sports, @info = username, email, sports, info
    # TODO: Permanently save user data to json.
  end

  # Created 09/25/2019 by Neel Mansukhani
  # TODO: createEmail to create_email refractor.
  def createEmail(all_schedules_and_news)
    user_file = File.open "user_information/#{@username}.txt", 'w'
    user_file.puts @email
    if @info.include? 'News'
      @sports.each do |sport|
        user_file.puts "#{sport} News"
        news = getNews sport, all_schedules_and_news
        news.display user_file
      end
    end
    if @info.include? 'Schedule'
      @sports.each do |sport|
        user_file.puts "#{sport} Schedule"
        schedule = getSchedule sport, all_schedules_and_news
        schedule.display user_file
      end
    end
    user_file.close
  end
end

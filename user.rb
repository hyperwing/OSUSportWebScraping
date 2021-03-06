# File Created 09/25/2019 by Neel Mansukhani
# Edited 10/05/2019 by Sharon Qiu
# Edited 10/05/2019 by Neel Mansukhani
# Creates user preferences and emails

require_relative 'cron_job/create_cron_job'


# Created 09/25/2019 by Neel Mansukhani
# Edited 10/05/2019 by Sharon Qiu: added edits to create email for parsing by keyword for news.
class User

  attr_accessor :sports, :info
  # Created 09/25/2019 by Neel Mansukhani
  def initialize(username, email, sports, info, subscription)
    @username = username
    @email = email
    @sports = sports
    @info = info
    @subscription = subscription
  end

  # Created 09/25/2019 by Neel Mansukhani
  # Edited 10/05/2019 by Sharon Qiu: references to news and schedules have been fixed. Also added keywords
  # Edited 10/05/2019 by Neel Mansukhani: added get_user_preferences as class function
  # Creates/write email File;
  def create_email(sports_news, schedules)
    email = ""
    if @info.include? 'News'
      @sports.each do |sport|
        news = get_news sport, sports_news
        email += news.display [], email
      end
    end
    if @info.include? 'Schedule'
      @sports.each do |sport|
        email += "#{sport} Schedule\n"
        schedule = get_schedule sport, schedules
        email += schedule.display email
      end
    end
    email
  end

  # Created 10/06/2019 by Neel Mansukhani
  # Sends self's email based on user preferences
  def send_email(news_info, schedules, client)
    body = create_email news_info, schedules
    m = Mail.new to: @email, from: "osusportsdigest@gmail.com", charset: "UTF-8", subject: "OSU Sports Digest", body: body
    message_object = Google::Apis::GmailV1::Message.new raw: m.encoded
    client.send_user_message 'me', message_object
  end

  # Created 09/26/2019 by Neel Mansukhani
  # Edited 10/04/2019 by Sri Ramya Dandu: Factored input to functions
  # Edited 10/05/2019 by Sri Ramya Dandu: Fixed case issues
  # Edited 10/05/2019 by Neel Mansukhani: Moved to user class as class function
  # Edited 10/06/2019 by Neel Mansukhani: Checks for used usernames
  # Gets user info and creates user obj
  def self.get_user_preferences(sports_reg_ex, username)
    email = ""
    while !is_valid_email? email
      print "Please enter a valid osu email address: "
      email = gets.chomp
    end
    yes_no = "Y"
    sports = []
    list_sports sports_reg_ex
    while yes_no == "Y"
      sports.push get_sport_choice sports_reg_ex
      yes_no = yes_no_input "Would you like to add another sport? (Y/N): "
    end
    info_selection = ""
    while info_selection != "schedule" && info_selection != "news" && info_selection != "both"
      print "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both: "
      info_selection = gets.chomp.downcase
    end
    info = []
    case info_selection
    when "schedule"
      info.push"Schedule"
    when "news"
      info.push"News"
    when "both"
      info.push"Schedule"
      info.push"News"
    end
    subscription = ""
    while subscription != "daily" && subscription != "weekly" && subscription != "monthly"
      print "How often do you want emails? Enter 'Daily', 'Weekly', or 'Monthly': "
      subscription = gets.chomp.downcase
      set_cron_job
    end
    u = User.new username, email, sports, info, subscription
    u.add_user_to_json
    u
  end

  # Created 10/06/2019 by Neel Mansukhani
  # Adds self to the user data json.
  def add_user_to_json
    hash = JSON.load File.new 'user_information/user_data.json'
    hash[@username] = Hash.new
    hash[@username]['email'] = @email
    hash[@username]['sports'] = @sport
    hash[@username]['info'] = @info
    hash[@username]['subscription'] = @subscription
    hash[@username]['last_email_sent'] = Time.now.strftime "%d/%m/%Y"
    File.open "user_information/user_data.json","w" do |f|
      f.puts JSON.pretty_generate hash
    end
  end

  # Created 10/06/2019 by Neel Mansukhani
  # Removes self from user data json.
  def remove_user_from_json
    hash = JSON.load File.new 'user_information/user_data.json'
    hash.delete @username
    File.open "user_information/user_data.json","w" do |f|
      f.puts JSON.pretty_generate hash
    end
  end
end

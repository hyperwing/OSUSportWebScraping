# File Created 09/25/2019 by Neel Mansukhani
# Edited 10/05/2019 by Sharon Qiu
# Edited 10/05/2019 by Neel Mansukhani


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
    last_email_sent =  Time.now.strftime "%d/%m/%Y"
    # TODO: send email
    hash = JSON.load 'user_information/user_data.json'
    hash[username] = Hash.new
    hash[username]['email'] = @email
    hash[username]['sports'] = @sport
    hash[username]['info'] = @info
    hash[username]['subscription'] = @subscription
    hash[username]['last_email_sent'] = Time.now.strftime "%d/%m/%Y"
    File.open "user_information/user_data.json","w" do |f|
      f.write hash.to_json
    end
  end

  # Created 09/25/2019 by Neel Mansukhani
  # Edited 10/05/2019 by Sharon Qiu: references to news and schedules have been fixed. Also added keywords
  # Edited 10/05/2019 by Neel Mansukhani: added get_user_preferences as class function
  def create_email(sports_news, schedules)
    user_file = File.open "user_information/#{@username}.txt", 'w'
    user_file.puts @email
    if @info.include? 'News'
      kw = get_search_keywords #gets keywords
      @sports.each do |sport|
        news = get_news sport, sports_news
        news.display kw, user_file
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
  # Created 09/26/2019 by Neel Mansukhani
  # Edited 10/04/2019 by Sri Ramya Dandu: Factored input to functions
  # Edited 10/05/2019 by Sri Ramya Dandu: Fixed case issues
  # Edited 10/05/2019 by Neel Mansukhani: Moved to user class as class function
  # Gets user info and creates file containing email contents
  def self.get_user_preferences(sports_reg_ex)
    print "Please enter a username: "
    username = gets.chomp # TODO: Check if username already exists and don't ask for email on return of user
    print "Please enter a valid email address: "
    email = gets.chomp
    while !isValidEmail? email
      puts "Please enter a valid email address: "
      email = gets.chomp
    end
    yes_no = "Y"
    sports = []
    while yes_no == "Y"
      # TODO: Add display list of sports.
      sports.push(get_sport_choice sports_reg_ex)
      yes_no = yes_no_input "Would you like to add another sport? (Y/N): "
    end
    s_n_b = ""
    while s_n_b != "schedule" && s_n_b != "news" && s_n_b != "both"
      print "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both: "
      s_n_b = gets.chomp.downcase
    end
    info = []
    case s_n_b
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
      print "How often do you want emails? Enter 'Daily', 'Weekly', or 'Monthly'"
      subscription = gets.chomp.downcase
    end
    User.new username, email, sports, info, subscription
  end
end

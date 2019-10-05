# File created 10/05/2019 by Sharon Qiu
# Puts all methods that compile retunred information together.

require_relative 'info_scrape'
require_relative 'user'
require_relative 'utilities'

# Created 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani: Returns sport schedule instead of printing
def get_schedule(sport, all_schedules)
    all_schedules.each do |current|
        return current if current.sport == sport
    end
end

# Created 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani: Returns sport news instead of printing
def get_news(sport, all_news)
    all_news.each do |current|
        return current if current.sport == sport
    end
end

# Created 10/05/2019 by Sharon Qiu
# Returned keywords to search by. Returns keywords array
def get_search_keywords
    search_by_keyword = yes_no_input "Would you like to search news article titles by keyword(Y/N)? "
    keywords = ""
    if search_by_keyword == "Y"
        loop do
            print "Enter your keyword(s): "
            inputKeys = gets.chomp.split " " #splits
            keywords = inputKeys.map {|kw| kw.strip} #strips words of trailing whitespace, just in case
            kw_valid = kw_validity? keywords
            if !kw_valid
                puts 'keywords invalid! Be sure that you are entering real words or numbers.'
            else
                break
            end         
        end
    end
    keywords
end
# TODO: Make class method of user?
# Created 09/26/2019 by Neel Mansukhani
# Edited 10/04/2019 by Sri Ramya Dandu: Factored input to functions
# Gets user info and creates file containing email contents
def get_user_preferences(sports_reg_ex)
    print "Please enter a username: "
    username = gets.chomp # TODO: Check if username already exists and don't ask for email on return of user
    print "Please enter a valid email address: "
    email = gets.chomp
    while !isValidEmail? email # TODO: Create Regex in utilities
        puts "Please enter a valid email address: "
        email = gets.chomp
    end
    # TODO: Add how often they want emails
    yes_no = "Y"
    sports = []
    while yes_no == "Y"

        # TODO: Add display list of sports.
        # TODO: Add error msg.
        sports.push(get_sport_choice sports_reg_ex)
        yes_no = yes_no_input "Would you like to add another sport? (Y/N): "
    end
    s_n_b = ""
    while s_n_b != "Schedule" && s_n_b != "News" && s_n_b != "Both"
        print "Please enter 'Schedule' for schedule information, 'News' for news, or 'Both' for both: "
        s_n_b = gets.chomp
    end
    info = []
    case s_n_b
    when "Schedule"
        info.push"Schedule"
    when "News"
        info.push"News"
    when "Both"
        info.push"Schedule"
        info.push"News"
    end
    User.new username, email, sports, info
end

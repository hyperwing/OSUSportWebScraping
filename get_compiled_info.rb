# File created 10/05/2019 by Sharon Qiu
# Edited 10/04/2019 by Sri Ramya Dandu
# Edited 10/05/2019 by Neel Mansukhani: moved get_user_preferences
# Puts all methods that compile returned information together.

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
    keywords = []
    if search_by_keyword == "Y"
        kw_valid = false
        while !kw_valid
            print "Enter your keyword(s): "
            inputKeys = gets.chomp.split " " #splits keywords
            keywords = inputKeys.map {|kw| kw.strip} #strips words of trailing whitespace, just in case
            kw_valid = kw_validity? keywords
            puts 'keywords invalid! Be sure that you are entering real words or numbers.' if !kw_valid         
        end
    end
    keywords
end


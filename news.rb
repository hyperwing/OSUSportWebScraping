# File Created 09/24/2019 by Leah Gillespie
# Edited 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani
# Edited 10/05/2019 by Sharon Qiu
# Edited 10/06/2019 by Neel Mansukhani
# Stores news information

require_relative 'utilities'

# Created 09/24/2019 by Leah Gillespie
# Edited 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani
# Edited 10/05/2019 by Sharon Qiu
# Edited 10/06/2019 by Neel Mansukhani
# Stores news information
class News

  attr_reader :sport , :news

  # Created 09/24/2019 by Leah Gillespie
  def initialize(sport, news)
    @sport = sport
    @news = news
  end

  # Created 09/24/2019 by Leah Gillespie
  # Edited 09/26/2019 by Leah Gillespie
  # Edited 09/26/2019 by Neel Mansukhani: Prints to file if specified
  # Edited 10/05/2019 by Sharon Qiu: auto-initialized nil and allowed keyword_list for querying through news articles
  # Edited 10/06/2019 by Neel Mansukhani: Returns string
  # Displays news info to terminal if output is nil. Else it returns a string
  def display(keyword_list, output = nil)
    # Article Query count
    count = 0
    # String to be returned
    str = ""
    # Keyword handling
    kw_str = ""
    keyword_list.each {|word| kw_str += ":" + word}

    if output.nil?
      if !keyword_list.empty?
        puts "OSU #{sport} News with relational keywords #{kw_str}"
      else
        puts "OSU #{sport} News"
      end

      @news.each do |article|
        if article_match? keyword_list, article[1]
          count += 1
          puts "OSU #{@sport} news, #{article[0]}: #{article[1]}"
          puts "For more information, go to #{article[2]}"
        end
      end
      puts "No articles found." if count == 0
    else
      str += "OSU #{sport} News\n"
      @news.each do |article|
        count += 1
        str += "OSU #{@sport} news, #{article[0]}: #{article[1]}\n"
        str += "For more information, go to #{article[2]}\n"
      end
      str += "No articles found.\n" if count == 0
    str
    end
  end
end

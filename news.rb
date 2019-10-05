# File Created 09/24/2019 by Leah Gillespie
# Edited 10/05/2019 by Sharon Qiu

require_relative 'utilities'

# Created 09/24/2019 by Leah Gillespie
# Edited 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani
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
  def display(keyword_list = nil, output = nil)
    if output.nil?
      if !keyword_list.nil?
        @news.each do |article|
          if article_match? keyword_list, article[1]
            puts "OSU #{@sport} news, #{article[0]}: #{article[1]}"
            puts "For more information, go to #{article[2]}"
          end
        end
      else
        @news.each do |article|
          puts "OSU #{@sport} news, #{article[0]}: #{article[1]}"
          puts "For more information, go to #{article[2]}"
        end
      end
    else
      if !keyword_list.nil?
        @news.each do |article|
          if article_match? keyword_list, article[1]
            output.puts "OSU #{@sport} news, #{article[0]}: #{article[1]}"
            output.puts "For more information, go to #{article[2]}"
          end
        end
      else
        @news.each do |article|
          output.puts "OSU #{@sport} news, #{article[0]}: #{article[1]}"
          output.puts "For more information, go to #{article[2]}"
        end
      end
    end
  end
end

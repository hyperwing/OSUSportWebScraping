# File created 09/24/2019 by Leah Gillespie

# Created 09/24/2019 by Leah Gillespie
# Edited 09/26/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani
class News

  attr_reader :sport, :date

  # Created 09/24/2019 by Leah Gillespie
  def initialize(sport, news)
    @sport = sport
    @news = news
  end

  # Created 09/24/2019 by Leah Gillespie
  # Edited 09/26/2019 by Leah Gillespie
  # Edited 09/26/2019 by Neel Mansukhani: Prints to file if specified
  def display output
    if output.nil?
      @news.each do |article|
        puts "OSU #{@sport} news, #{article[0]}: #{article[1]}"
        puts "For more information, go to #{article[2]}"
      end
    else
      @news.each do |article|
        output.puts "OSU #{@sport} news, #{article[0]}: #{article[1]}"
        output.puts "For more information, go to #{article[2]}"
      end
    end
  end
end
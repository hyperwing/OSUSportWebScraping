# File created 09/24/2019 by Leah Gillespie

# Created 09/24/2019 by Leah Gillespie
# Edited 09/26/2019 by Leah Gillespie
class News

  attr_reader :sport, :date

  # Created 09/24/2019 by Leah Gillespie
  def initialize(sport, news)
    @sport = sport
    @news = news
  end

  # Created 09/24/2019 by Leah Gillespie
  # Edited 09/26/2019 by Leah Gillespie
  def display()
    @news.each do |article|
      puts "OSU #{@sport} news, #{article[0]}: #{article[1]}"
      puts "For more information, go to #{article[2]}"
    end
  end

end
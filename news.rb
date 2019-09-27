# File created 09/24/2019 by Leah Gillespie

# Created 09/24/2019 by Leah Gillespie
class News

  attr_reader :sport, :date

  # Created 09/24/2019 by Leah Gillespie
  def initialize(sport, date, headline, url)
    @sport = sport
    @date = date
    @headline = headline
    @url = url
  end

  # Created 09/24/2019 by Leah Gillespie
  # Edited 09/26/2019 by Neel Mansukhani: Prints to file if specified
  def display output
    if output.nil?
      puts "OSU #{@sport} news, #{@date}: #{@headline}"
      puts "For more information, go to #{@url}"
    else
      output.puts "OSU #{@sport} news, #{@date}: #{@headline}"
      output.puts "For more information, go to #{@url}"
    end
  end

end
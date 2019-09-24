# Created 09/24/2019 by Leah Gillespie
class News
  # Created 09/24/2019 by Leah Gillespie
  def initialize (team, date, headline, url)
    @team = team
    @date = date
    @headline = headline
    @url = url
  end

  # Created 09/24/2019 by Leah Gillespie
  def display()
    puts "OSU #{@team} news for #{@date}: #{@headline}"
    puts "For more information, go to #{@url}"
  end
end
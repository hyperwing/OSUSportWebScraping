# File created 09/24/2019 by Leah Gillespie

# Created 09/24/2019 by Leah Gillespie
class Schedule

  attr_reader :sport

  # Created 09/24/2019 by Leah Gillespie
  def initialize(sport, schedule)
    @sport = sport
    @schedule = schedule
  end

  # Created 09/24/2019 by Leah Gillespie
  def display()
    @schedule.each do |game|
      if game[2] == "home"
        puts "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} at home."
      else
        puts "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} away."
      end
    end
  end

end
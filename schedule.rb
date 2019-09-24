# File created 09/24/2019 by Leah Gillespie

# Created 09/24/2019 by Leah Gillespie
class Schedule

  attr_reader :sport, :date, :opponent, :location

  # Created 09/24/2019 by Leah Gillespie
  def initialize(sport, date, opponent, location)
    @sport = sport
    @date = date
    @opponent = opponent
    @location = location
    if location == "Columbus"
      @home = true
    else
      @home = false
    end
  end

  # Created 09/24/2019 by Leah Gillespie
  def display()
    if @home
      puts "On #{@date}, OSU's #{@sport} team played #{@opponent} at home."
    else
      puts "On #{@date}, OSU's #{@sport} team played #{@opponent} in #{@location}."
    end
  end

end
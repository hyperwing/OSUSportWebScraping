# File created 09/24/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani
# Edited 10/06/2019 by Neel Mansukhani

# TODO:refactor schedule.rb

# Created 09/24/2019 by Leah Gillespie
# Edited 10/06/2019 by Neel Mansukhani
# stores schedule info for specific sport
class Schedule

  attr_reader :sport

  # Created 09/24/2019 by Leah Gillespie
  def initialize(sport, schedule)
    @sport = sport
    @schedule = schedule
  end  

  # Created 09/24/2019 by Leah Gillespie
  # Edited 09/26/2019 by Neel Mansukhani: Prints to file if specified
  # Edited 10/06/2019 by Neel Mansukhani: Returns string
  # Displays schedule information to terminal if output is nil. Else it returns a string
  def display(output)
    # String to be returned
    str = ""
    if output.nil?
      @schedule.each do |game|
        if game[2] == "home"
          puts "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} at home."
        else
          puts "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} away."
        end
      end

      puts "No schedule available at this time!" if @schedule.length == 0

    else
      @schedule.each do |game|
        if game[2] == "home"
          str += "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} at home.\n"
        else
          str += "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} away.\n"
        end
      end
      str += "No schedule available at this time!\n" if @schedule.length == 0
    end
    str
  end
end

# File created 09/24/2019 by Leah Gillespie
# Edited 09/26/2019 by Neel Mansukhani

# TODO:refactor schedule.rb

# Created 09/24/2019 by Leah Gillespie
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
  # Displays schedule information
  def display(output)
    if output.nil?
      @schedule.each do |game|
        if game[2] == "home"
          puts "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} at home."
        else
          puts "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} away."
        end
      end

      "No schedule available at this time!" if @schedule.length == 0

    else
      @schedule.each do |game|
        if game[2] == "home"
          output.puts "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} at home."
        else
          output.puts "On #{game[0]}, OSU's #{@sport} team plays #{game[1]} away."
        end
      end
      "No schedule available at this time!" if @schedule.length == 0

    end
  end
end

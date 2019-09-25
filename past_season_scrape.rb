# File created 09/24/2019 by David Wing
# Obtains past season wins/loss and other stats.
# https://ohiostatebuckeyes.com/ 

require "mechanize"
require_relative 'schedule.rb'
    
# Created 09/24/2019 by David Wing
class Season

    attr_reader :sport, :year #, wins, losses, streak, pct

    # Created 09/24/2019 by David Wing
    def initialize sport, year
        @sport = sport
        @year = year
    end

    # Created 09/24/2019 by David Wing
    # checks whether given sport has a record for the year provided
    # Params:
    # sport-> String name of sport, season-> int year of the season start
    def season_exists

        agent = Mechanize.new

        year_string = @year.to_s + "-" + (@year+1).to_s[2..]
        page = agent.get("https://ohiostatebuckeyes.com/sports/" + @sport + "/schedule/season/" + year_string)

        not page.search("h2").xpath("text()").text.strip == "Events aren't found for the selected season"
            
    end

    def update_stats
        return true
    end

end
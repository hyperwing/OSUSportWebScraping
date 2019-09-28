# File created 09/24/2019 by David Wing
# Obtains past season wins/loss and other stats.
# https://ohiostatebuckeyes.com/ 

require 'mechanize'
require_relative 'schedule'
    
# Created 09/24/2019 by David Wing
class Season

    attr_reader :sport, :year, :wins, :losses, :ties, :streak, :pct

    # Created 09/24/2019 by David Wing
    def initialize(sport, year)
        # TODO: Decrease lines
        @sport = sport
        @year = year
        @wins =0
        @losses = 0
        @ties=0
        @streak=0
        @pct = 0.0
        update_stats if season_exists
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

    # Created 9/24/2019 by David Wing
    # updates the statistics of a given year
    def update_stats

        agent = Mechanize.new

        year_string = @year.to_s + "-" + (@year+1).to_s[2..]
        page = agent.get("https://ohiostatebuckeyes.com/sports/" + @sport + "/schedule/season/" + year_string)

        all_games = page.search("//div[@class='ohio--schedule-list ohio--schedule-page']").children.children.children.children
        
        # TODO: 1 liner
        max_streak = 0
        streak = 0
        all_games.children.each do |game|

            #TODO: streaks
            case game.text.strip
            when "W"
                @wins += 1
                streak += 1
            when "T"
                @ties += 1
                max_streak = [max_streak, streak].max
                streak = 0
            when "L"
                @losses += 1
                max_streak = [max_streak, streak].max
                streak = 0
            else
                puts game
            end
            # puts game
        end
        @streak = max_streak
        @pct =((@wins + @ties) / (@wins+@ties+@losses).to_f)
        # TODO: More stats
    end

end

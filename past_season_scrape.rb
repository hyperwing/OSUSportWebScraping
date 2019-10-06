# File created 09/24/2019 by David Wing
# File edited 10/05/2019 by David Wing
# File edited 10/06/2019 by David Wing
# Obtains past season wins/loss and other stats.
# https://ohiostatebuckeyes.com/ 

require 'mechanize'
require_relative 'schedule'
    
# Created 09/24/2019 by David Wing
class Season

    attr_reader :sport, :year, :wins, :losses, :ties, :streak, :pct, :loss_streak, :points_for, :points_against, :average_points

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
        @loss_streak = 0
        @points_for = 0
        @points_against = 0
        @average_points = 0
        update_stats if season_exists
    end

    # Created 10/06/2019 by Leah Gillespie
    def display
        puts "For the #{@year} season, OSU's #{@sport} team had a record of #{@wins} - #{@losses} - #{@ties}. Their longest winning streak was #{@streak} wins, and they won #{@pct} of their games."
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
    # Edited 10/05/2019 by David Wing
    # updates the statistics of a given year
    def update_stats
        agent = Mechanize.new

        year_string = @year.to_s + "-" + (@year+1).to_s[2..]
        page = agent.get("https://ohiostatebuckeyes.com/sports/" + @sport + "/schedule/season/" + year_string)

        all_games = page.search("//div[@class='ohio--schedule-list ohio--schedule-page']").children.children.children.children
        
        results = page.search("//span[@class='results']")
        # puts(results)
        
        number_of_games = results.children.length

        won = false
        results.children.each do |result|

            # puts result.text.strip

            if result.text.strip == "W"
                won = true
            elsif result.text.strip == "L"
                won = false
            elsif result.text.strip =="T"
                won = true
            else
                if result.text.strip.length >0
                    # puts result.text.strip
                    if won
                        @points_for += result.text.strip.match(/[0-9]*/)[0].to_i
                        @points_against += result.text.strip.match(/-[0-9]*/)[0].to_i * -1
                    else
                        @points_against += result.text.strip.match(/[0-9]*/)[0].to_i
                        @points_for += result.text.strip.match(/-[0-9]*/)[0].to_i * -1
                    end
                end
            end
        end

        @average_points = points_for.to_f/number_of_games.to_f

        max_streak = 0
        streak = 0
        loss_streak = 0
        all_games.children.each do |game|

            #TODO: streaks
            case game.text.strip
            when "W"
                @wins += 1
                streak += 1
                loss_streak =0
            when "T"
                @ties += 1
                max_streak = [max_streak, streak].max
                streak = 0
                loss_streak =0
            when "L"
                @losses += 1
                max_streak = [max_streak, streak].max
                streak = 0
                loss_streak +=1
            else
                puts game
            end
            # puts game
        end
        @streak = max_streak
        @loss_streak = loss_streak
        @pct =((@wins + @ties) / (@wins+@ties+@losses).to_f)
        # TODO: More stats
    end

end

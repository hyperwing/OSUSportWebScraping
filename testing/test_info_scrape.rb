# File created 10/04/2019 by Sri Ramya Dandu
# Edited 10/06/2019 by Sri Ramya Dandu

# Tests that functions in the info_scrape file
<<<<<<< HEAD
require_relative "../cache/info_scrape"
require 'mechanize'
=begin
# Created 10/04/2019 by Sri Ramya Dandu
# Tests for valid schedule scrape for sports.
=======

require 'mechanize'
require_relative '../info_scrape'

# Created 10/04/2019 by Sri Ramya Dandu
# Edited 10/06/2019 by Sri Ramya Dandu: Works with cached files
>>>>>>> ee3dfbfce0add6607dab8b8978856a7083a21b2e
context 'Checks for valid schedules' do

  it "obtains a long schedule for Field Hockey" do
    agent = Mechanize.new
    html_dir = File.dirname(__FILE__)
    page = agent.get("file:///#{html_dir}/Field Hockey.html")
    game_info = parse_schedule page
    expect(game_info).to eq([["Sun Aug 25", "Michigan", "away"], ["Fri Sep 6", "James Madison", "away"], ["Sun Sep 8", "Virginia", "away"], ["Fri Sep 27", "Iowa", "away"], ["Sun Sep 29", "Indiana", "away"], ["Sun Oct 6", "Ohio", "away"], ["Fri Oct 25", "Penn State", "away"], ["Sun Oct 27", "Kent State", "away"], ["Sat Nov 2", "Michigan State", "away"], ["Sat Aug 17", "Ohio", "home"], ["Fri Aug 30", "UMass", "home"], ["Mon Sep 2", "Boston University", "home"], ["Fri Sep 13", "Central Michigan", "home"], ["Sun Sep 15", "Louisville", "home"], ["Fri Sep 20", "Northwestern", "home"], ["Fri Oct 11", "Michigan", "home"], ["Sun Oct 13", "Stanford", "home"], ["Fri Oct 18", "Rutgers", "home"], ["Sun Oct 20", "Maryland", "home"]])
  end

  it "obtains a short schedule for Women's Tennis" do
    agent = Mechanize.new
    html_dir = File.dirname(__FILE__)
    page = agent.get("file:///#{html_dir}/Tennis, Women's.html")
    game_info = parse_schedule page
    expect(game_info).to eq([["Fri Sep 20", "Furman Fall Classic", "away"]])
  end

  it "obtains a medium schedule for Softball" do
    agent = Mechanize.new
<<<<<<< HEAD
    bad_link = agent.get "https://ohiostatebuckeyes.com/sports/w-syncs/"
    game_info = parse_schedule bad_link
    expect(game_info).to eq([["Sat Jan 26", "Minnesota", "away"], ["Sun Jan 27", "Michigan", "away"], ["Sat Feb 9", "Richmond", "... "OSU Zero Waste Invitational", "home"], ["Sat Feb 2", "Jessica Beck Memorial Competition", "home"]]
  end
end
=end
=======
    html_dir = File.dirname(__FILE__)
    page = agent.get("file:///#{html_dir}/Softball.html")
    game_info = parse_schedule page
    expect(game_info).to eq([["Sun Oct 6", "Dayton", "away"], ["Sun Sep 22", "Wright State", "home"], ["Sun Sep 22", "Wright State", "home"], ["Fri Sep 27", "Scarlet vs. Gray", "home"], ["Sat Sep 28", "Toledo", "home"], ["Sat Sep 28", "Akron", "home"], ["Sun Sep 29", "Alumni Practice", "home"]])
  end

  it "obtains a schedule for Men's Tennis" do
    agent = Mechanize.new
    html_dir = File.dirname(__FILE__)
    page = agent.get("file:///#{html_dir}/Tennis, Men's.html")
    game_info = parse_schedule page
    expect(game_info).to eq([["Sat Feb 22", "Notre Dame", "away"], ["Sun Mar 1", "Georgia", "away"], ["Wed Mar 4", "Stanford", "away"], ["Sun Mar 15", "Michigan State", "away"], ["Fri Apr 3", "Purdue", "away"], ["Sun Apr 5", "Indiana", "away"], ["Fri Apr 17", "Wisconsin", "away"], ["Sun Apr 19", "Minnesota", "away"], ["Sun Jan 19", "Xavier", "home"], ["Sun Jan 19", "Wright State", "home"], ["Sat Jan 25", "Purdue (ITA Kick-off)", "home"], ["Sun Jan 26", "Tulsa/Utah (ITA Kick-off)", "home"], ["Sun Jan 26", "Toledo", "home"], ["Sat Feb 1", "Texas", "home"], ["Fri Feb 7", "Arizona State", "home"], ["Sun Feb 9", "USC", "home"], ["Tue Feb 11", "Texas A&M", "home"], ["Sun Mar 8", "Penn State", "home"], ["Fri Mar 20", "Michigan", "home"], ["Fri Mar 27", "Nebraska", "home"], ["Sun Mar 29", "Iowa", "home"], ["Fri Apr 10", "Northwestern", "home"], ["Sun Apr 12", "Illinois", "home"]])
  end

end
>>>>>>> ee3dfbfce0add6607dab8b8978856a7083a21b2e

# File created 10/04/2019 by Sri Ramya Dandu

# Tests that functions in the info_scrape file
require_relative "../info_scrape"
require 'mechanize'
=begin
# Created 10/04/2019 by Sri Ramya Dandu
# Tests for valid schedule scrape for sports.
context 'Checks for valid schedules' do
  it "obtains a long schedule for Field Hockey" do
    agent = Mechanize.new
    field_hockey_link = agent.get "https://ohiostatebuckeyes.com/sports/w-fieldh/"
    game_info = parse_schedule field_hockey_link
    expect(game_info).to eq([["Sun Aug 25", "Michigan", "away"], ["Fri Sep 6", "James Madison", "away"], ["Sun Sep 8", "Virginia", "away"], ["Fri Sep 27", "Iowa", "away"], ["Sun Sep 29", "Indiana", "away"], ["Sun Oct 6", "Ohio", "away"], ["Fri Oct 25", "Penn State", "away"], ["Sun Oct 27", "Kent State", "away"], ["Sat Nov 2", "Michigan State", "away"], ["Sat Aug 17", "Ohio", "home"], ["Fri Aug 30", "UMass", "home"], ["Mon Sep 2", "Boston University", "home"], ["Fri Sep 13", "Central Michigan", "home"], ["Sun Sep 15", "Louisville", "home"], ["Fri Sep 20", "Northwestern", "home"], ["Fri Oct 11", "Michigan", "home"], ["Sun Oct 13", "Stanford", "home"], ["Fri Oct 18", "Rutgers", "home"], ["Sun Oct 20", "Maryland", "home"]])
  end

  it "obtains a medium sized schedule" do
    agent = Mechanize.new
    bad_link = agent.get "https://ohiostatebuckeyes.com/sports/w-syncs/"
    game_info = parse_schedule bad_link
    expect(game_info).to eq([["Sat Jan 26", "Minnesota", "away"], ["Sun Jan 27", "Michigan", "away"], ["Sat Feb 9", "Richmond", "... "OSU Zero Waste Invitational", "home"], ["Sat Feb 2", "Jessica Beck Memorial Competition", "home"]]
  end
end
=end

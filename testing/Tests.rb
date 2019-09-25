require_relative("../past_season_scrape")

context "Checks if season has statistics " do

    it "Returns true when Season 2010-2011 has stats" do
       men_soccer_10 = Season.new("m-soccer", 2010)
       expect(men_soccer_10.season_exists).to eq(true)
    end

    it "Returns false when Season 1993-1994 has stats" do
        men_soccer_10 = Season.new("m-soccer", 1993)
        expect(men_soccer_10.season_exists).to eq(false)
     end
end
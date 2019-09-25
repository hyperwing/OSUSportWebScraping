require_relative("../past_season_scrape")

context "Checks if season has statistics " do

    it "Returns true when mens Soccer Season 2010-2011 has stats" do
       men_soccer_10 = Season.new("m-soccer", 2010)
       expect(men_soccer_10.season_exists).to eq(true)
    end

    it "Returns false when mens Soccer Season 1993-1994 doesnt have stats" do
        men_soccer_93 = Season.new("m-soccer", 1993)
        expect(men_soccer_93.season_exists).to eq(false)
    end

    it "Returns true when womens lacrosse Season 2017-2018 has stats" do
        womens_lax_17 = Season.new("w-lacros", 2017)
        expect(womens_lax_17.season_exists).to eq(true)
    end

    it "Returns false when mens T&F Season 1990-1991 doesnt have stats" do
        men_TF_93 = Season.new("m-track", 1993)
        expect(men_TF_93.season_exists).to eq(false)
    end
end

context "Updates season statistics " do

    it "Returns correct stats when mens Soccer Season 2011-12 is updated with stats" do
       men_soccer_11 = Season.new("m-soccer", 2011)

       expect(men_soccer_11.pct).to eq(2.0/3.0)
       expect(men_soccer_11.streak).to eq(4)
       expect(men_soccer_11.wins).to eq(10)
       expect(men_soccer_11.losses).to eq(7)
       expect(men_soccer_11.ties).to eq(4)

    end


    it "Returns correct stats when womens basketball Season 2016-17 is updated with stats" do
        w_bball_16 = Season.new("w-baskbl", 2016)
 
        expect(w_bball_16.pct).to eq(29.0/36.0)
        expect(w_bball_16.streak).to eq(12)
        expect(w_bball_16.wins).to eq(29)
        expect(w_bball_16.losses).to eq(7)
        expect(w_bball_16.ties).to eq(0)
 
     end

     it "Returns correct stats when mens baseball Season 2017-18 is updated with stats" do
        m_bb_17 = Season.new("m-basebl", 2017)
 
        expect(m_bb_17.pct).to eq(36.0/60.0)
        expect(m_bb_17.streak).to eq(7)
        expect(m_bb_17.wins).to eq(36)
        expect(m_bb_17.losses).to eq(24)
        expect(m_bb_17.ties).to eq(0)
 
     end
end
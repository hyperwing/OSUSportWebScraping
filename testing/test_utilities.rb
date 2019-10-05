# File created 10/04/2019 by Sri Ramya Dandu

# Tests functions in the utilities file
require_relative("../utilities")

context 'Checks for valid regular expressions for sport' do
  it "creates reg exp for sport with no space or apostrophe" do
    reg_exp= create_reg_exp("soccer")
    expect(reg_exp).to eq(Regexp.new "socc|soc|so|s|occe|occ|oc|o|ccer|cce|cc|c|cer|ce|c|er|e|r")
  end

  it "creates reg exp for sport with a space and no apostrophe" do
    reg_exp= create_reg_exp("Field Hockey")
    expect(reg_exp).to eq(Regexp.new "Fiel|Fie|Fi|F|ield|iel|ie|i|eld |eld|el|e|ld H|ld |ld|l|d Ho|d H|d |d| Hoc| Ho| H| |Hock|Hoc|Ho|H|ocke|ock|oc|o|ckey|cke|ck|c|key|ke|k|ey|e|y")
  end

  it "creates reg exp for sport with no space and an apostrophe" do
    reg_exp= create_reg_exp("Fi'eld")
    expect(reg_exp).to eq(Regexp.new "Fi'e|Fi'|Fi|F|i'el|i'e|i'|i|'eld|'el|'e|'|eld|el|e|ld|l|d")
  end

  it "creates reg exp for sport with a space and an apostrophe" do
    reg_exp= create_reg_exp("Men's Soccer")
    expect(reg_exp).to eq(Regexp.new "Men'|Men|Me|M|en's|en'|en|e|n's |n's|n'|n|'s S|'s |'s|'|s So|s S|s |s| Soc| So| S| |Socc|Soc|So|S|occe|occ|oc|o|ccer|cce|cc|c|cer|ce|c|er|e|r")
  end
end

context 'Checks for valid auto suggestions' do

  sport_reg_exp = {"Men’s Cross Country"=>/Men’|Men|Me|M|en’s|en’|en|e|n’s |n’s|n’|n|’s C|’s |’s|’|s Cr|s C|s |s| Cro| Cr| C| |Cros|Cro|Cr|C|ross|ros|ro|r|oss |oss|os|o|ss C|ss |ss|s|s Co|s C|s |s| Cou| Co| C| |Coun|Cou|Co|C|ount|oun|ou|o|untr|unt|un|u|ntry|ntr|nt|n|try|tr|t|ry|r|y/, "Women’s Cross Country"=>/Wome|Wom|Wo|W|omen|ome|om|o|men’|men|me|m|en’s|en’|en|e|n’s |n’s|n’|n|’s C|’s |’s|’|s Cr|s C|s |s| Cro| Cr| C| |Cros|Cro|Cr|C|ross|ros|ro|r|oss |oss|os|o|ss C|ss |ss|s|s Co|s C|s |s| Cou| Co| C| |Coun|Cou|Co|C|ount|oun|ou|o|untr|unt|un|u|ntry|ntr|nt|n|try|tr|t|ry|r|y/, "Fencing"=>/Fenc|Fen|Fe|F|enci|enc|en|e|ncin|nci|nc|n|cing|cin|ci|c|ing|in|i|ng|n|g/, "Field Hockey"=>/Fiel|Fie|Fi|F|ield|iel|ie|i|eld |eld|el|e|ld H|ld |ld|l|d Ho|d H|d |d| Hoc| Ho| H| |Hock|Hoc|Ho|H|ocke|ock|oc|o|ckey|cke|ck|c|key|ke|k|ey|e|y/, "Men’s Golf"=>/Men’|Men|Me|M|en’s|en’|en|e|n’s |n’s|n’|n|’s G|’s |’s|’|s Go|s G|s |s| Gol| Go| G| |Golf|Gol|Go|G|olf|ol|o|lf|l|f/, "Women’s Golf"=>/Wome|Wom|Wo|W|omen|ome|om|o|men’|men|me|m|en’s|en’|en|e|n’s |n’s|n’|n|’s G|’s |’s|’|s Go|s G|s |s| Gol| Go| G| |Golf|Gol|Go|G|olf|ol|o|lf|l|f/, "Men’s Gymnastics"=>/Men’|Men|Me|M|en’s|en’|en|e|n’s |n’s|n’|n|’s G|’s |’s|’|s Gy|s G|s |s| Gym| Gy| G| |Gymn|Gym|Gy|G|ymna|ymn|ym|y|mnas|mna|mn|m|nast|nas|na|n|asti|ast|as|a|stic|sti|st|s|tics|tic|ti|t|ics|ic|i|cs|c|s/, "Women’s Ice Hockey"=>/Wome|Wom|Wo|W|omen|ome|om|o|men’|men|me|m|en’s|en’|en|e|n’s |n’s|n’|n|’s I|’s |’s|’|s Ic|s I|s |s| Ice| Ic| I| |Ice |Ice|Ic|I|ce H|ce |ce|c|e Ho|e H|e |e| Hoc| Ho| H| |Hock|Hoc|Ho|H|ocke|ock|oc|o|ckey|cke|ck|c|key|ke|k|ey|e|y/, "Women’s Lacrosse"=>/Wome|Wom|Wo|W|omen|ome|om|o|men’|men|me|m|en’s|en’|en|e|n’s |n’s|n’|n|’s L|’s |’s|’|s La|s L|s |s| Lac| La| L| |Lacr|Lac|La|L|acro|acr|ac|a|cros|cro|cr|c|ross|ros|ro|r|osse|oss|os|o|sse|ss|s|se|s|e/, "Pistol"=>/Pist|Pis|Pi|P|isto|ist|is|i|stol|sto|st|s|tol|to|t|ol|o|l/, "Rifle"=>/Rifl|Rif|Ri|R|ifle|ifl|if|i|fle|fl|f|le|l|e/, "Rowing"=>/Rowi|Row|Ro|R|owin|owi|ow|o|wing|win|wi|w|ing|in|i|ng|n|g/, "Men’s Soccer"=>/Men’|Men|Me|M|en’s|en’|en|e|n’s |n’s|n’|n|’s S|’s |’s|’|s So|s S|s |s| Soc| So| S| |Socc|Soc|So|S|occe|occ|oc|o|ccer|cce|cc|c|cer|ce|c|er|e|r/, "Women’s Soccer"=>/Wome|Wom|Wo|W|omen|ome|om|o|men’|men|me|m|en’s|en’|en|e|n’s |n’s|n’|n|’s S|’s |’s|’|s So|s S|s |s| Soc| So| S| |Socc|Soc|So|S|occe|occ|oc|o|ccer|cce|cc|c|cer|ce|c|er|e|r/, "Softball"=>/Soft|Sof|So|S|oftb|oft|of|o|ftba|ftb|ft|f|tbal|tba|tb|t|ball|bal|ba|b|all|al|a|ll|l|l/, "Men’s Swim & Dive"=>/Men’|Men|Me|M|en’s|en’|en|e|n’s |n’s|n’|n|’s S|’s |’s|’|s Sw|s S|s |s| Swi| Sw| S| |Swim|Swi|Sw|S|wim |wim|wi|w|im &|im |im|i|m & |m &|m |m| & D| & | &| |& Di|& D|& |&| Div| Di| D| |Dive|Div|Di|D|ive|iv|i|ve|v|e/, "Women’s Swim & Dive"=>/Wome|Wom|Wo|W|omen|ome|om|o|men’|men|me|m|en’s|en’|en|e|n’s |n’s|n’|n|’s S|’s |’s|’|s Sw|s S|s |s| Swi| Sw| S| |Swim|Swi|Sw|S|wim |wim|wi|w|im &|im |im|i|m & |m &|m |m| & D| & | &| |& Di|& D|& |&| Div| Di| D| |Dive|Div|Di|D|ive|iv|i|ve|v|e/, "Synchronized Swimming"=>/Sync|Syn|Sy|S|ynch|ync|yn|y|nchr|nch|nc|n|chro|chr|ch|c|hron|hro|hr|h|roni|ron|ro|r|oniz|oni|on|o|nize|niz|ni|n|ized|ize|iz|i|zed |zed|ze|z|ed S|ed |ed|e|d Sw|d S|d |d| Swi| Sw| S| |Swim|Swi|Sw|S|wimm|wim|wi|w|immi|imm|im|i|mmin|mmi|mm|m|ming|min|mi|m|ing|in|i|ng|n|g/, "Men’s Tennis"=>/Men’|Men|Me|M|en’s|en’|en|e|n’s |n’s|n’|n|’s T|’s |’s|’|s Te|s T|s |s| Ten| Te| T| |Tenn|Ten|Te|T|enni|enn|en|e|nnis|nni|nn|n|nis|ni|n|is|i|s/, "Women’s Tennis"=>/Wome|Wom|Wo|W|omen|ome|om|o|men’|men|me|m|en’s|en’|en|e|n’s |n’s|n’|n|’s T|’s |’s|’|s Te|s T|s |s| Ten| Te| T| |Tenn|Ten|Te|T|enni|enn|en|e|nnis|nni|nn|n|nis|ni|n|is|i|s/, "Men’s Track & Field"=>/Men’|Men|Me|M|en’s|en’|en|e|n’s |n’s|n’|n|’s T|’s |’s|’|s Tr|s T|s |s| Tra| Tr| T| |Trac|Tra|Tr|T|rack|rac|ra|r|ack |ack|ac|a|ck &|ck |ck|c|k & |k &|k |k| & F| & | &| |& Fi|& F|& |&| Fie| Fi| F| |Fiel|Fie|Fi|F|ield|iel|ie|i|eld|el|e|ld|l|d/, "Women’s Track & Field"=>/Wome|Wom|Wo|W|omen|ome|om|o|men’|men|me|m|en’s|en’|en|e|n’s |n’s|n’|n|’s T|’s |’s|’|s Tr|s T|s |s| Tra| Tr| T| |Trac|Tra|Tr|T|rack|rac|ra|r|ack |ack|ac|a|ck &|ck |ck|c|k & |k &|k |k| & F| & | &| |& Fi|& F|& |&| Fie| Fi| F| |Fiel|Fie|Fi|F|ield|iel|ie|i|eld|el|e|ld|l|d/, "Men’s Volleyball"=>/Men’|Men|Me|M|en’s|en’|en|e|n’s |n’s|n’|n|’s V|’s |’s|’|s Vo|s V|s |s| Vol| Vo| V| |Voll|Vol|Vo|V|olle|oll|ol|o|lley|lle|ll|l|leyb|ley|le|l|eyba|eyb|ey|e|ybal|yba|yb|y|ball|bal|ba|b|all|al|a|ll|l|l/}

  it 'returns Field Hockey for input hockey' do
    expect(auto_suggest "hockey",sport_reg_exp).to eq("Field Hockey")
  end

  it "returns women's soccer for input with wom" do
    expect(auto_suggest "wom soccer",sport_reg_exp).to eq("Women’s Soccer")
  end

  it "returns rowing for input with row" do
    expect(auto_suggest "Row",sport_reg_exp).to eq("Rowing")
  end

  it "returns correct sport for input with apostrophe" do
    expect(auto_suggest "Woen's Socc",sport_reg_exp).to eq("Women’s Soccer")
  end

  it "doesn't return a suggestion for blank input" do
    expect(auto_suggest "",sport_reg_exp).to eq("")
  end

  it "doesn't return a suggestion for one char input" do
    expect(auto_suggest "a",sport_reg_exp).to eq("")
  end

  it "doesn't return a suggestion for arbitrary input" do
    expect(auto_suggest "zadask",sport_reg_exp).to eq("")
  end

end


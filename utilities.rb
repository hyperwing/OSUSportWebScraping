# File Created 09/26/2019 by Neel Mansukhani
# Edited 10/04/2019 by Sri Ramya Dandu
# Edited 10/05/2019 by Sri Ramya Dandu
# File provides various functionality for input/output
# TODO: modularize file

# Created 10/04/2019 by Sri Ramya Dandu
# Outputs a list of all the sports options
def list_sports(sports_reg_ex)
  puts "\nHere is the list of OSU sports with free parking, free admission, and free fun!"
  i = 0
  sports_reg_ex.each_key do |sport|
    puts if i % 4 == 0
    print sport
    # Spaces evenly
    (28 - sport.length).times do
      print " "
    end
    i += 1
  end
  puts "\n"
end

# Created 10/04/2019 by Sri Ramya Dandu
# Edited 10/05/2019 by Sri Ramya Dandu: Fixed bugs in input
# Obtains a valid sports choice
def get_sport_choice(sports_reg_ex)
  print "Please enter the full name of a sport you would like information about:"
  # Converts input to match format how sports are stored
  sport = gets.chomp.gsub(/[A-Za-z']+/,&:capitalize)
  while !sports_reg_ex.has_key? sport
    sport_suggestion  = auto_suggest sport, sports_reg_ex

    if sport_suggestion != ""
      if (yes_no_input "Did you mean #{sport_suggestion}? (Y/N): ") == "Y"
        sport = sport_suggestion
      else
        list_sports sports_reg_ex if (yes_no_input "Would you like to see the list of sports again?") == "Y"
        print "Please enter the full name of a sport you would like information about:"
        sport = gets.chomp.gsub(/[A-Za-z']+/,&:capitalize)
      end
    else
      puts "Couldn't identify a sport!"
      list_sports sports_reg_ex if (yes_no_input "Would you like to see the list of sports again?") == "Y"
      print "Please enter the full name of a sport you would like information about:"
      sport = gets.chomp.gsub(/[A-Za-z']+/,&:capitalize)
    end
  end
  sport
end

# Created 10/04/2019 by Sri Ramya Dandu
# Obtains valid yes or no input
def yes_no_input(msg)
  print msg
  response = gets.chomp.upcase
  while response != "Y" && response != "N"
    puts "Error! Wrong input!"
    print msg
    response = gets.chomp.upcase
  end
  response
end

# Created 09/28/2019 by Sri Ramya Dandu
# Returns a regular expression that can identify the given sport
def create_reg_exp(sport)
  sport_regexp = ""
  sport_chars = sport.split ""
  sport_chars.each_index do |i|
    # regular expression contains substrings of various lengths
    sport_regexp += "|" + "#{sport_chars[i]}#{sport_chars[i + 1]}#{sport_chars[i + 2]}#{sport_chars[i+3]}" if i < sport.length - 3
    sport_regexp += "|" + "#{sport_chars[i]}#{sport_chars[i + 1]}#{sport_chars[i + 2]}" if i < sport.length - 2
    sport_regexp += "|" + "#{sport_chars[i]}#{sport_chars[i + 1]}" if i < sport.length - 1
    sport_regexp += "|" + "#{sport_chars[i]}" if i < sport.length
  end
  Regexp.new sport_regexp[1, sport_regexp.length]
end

# Created 09/28/2019 by Sri Ramya Dandu
# Edited 09/29/2019 by Sri Ramya Dandu: changed input to return a hash instead
# Returns a hashmap: key = sport, value = regular expression to identify sport
def sport_reg_exp (all_schedules)
  reg_exp_sports = Hash.new
  all_schedules.each do |current|
    reg_exp_sports[current.sport] = create_reg_exp current.sport
  end
  reg_exp_sports
end

# Created 09/29/2019 by Sri Ramya Dandu
# Edited 10/04/2019 by Sri Ramya Dandu: made suggestion more accurate
# Returns a suggested sport for the input using regular expressions
def auto_suggest(input,sports_reg_exp)
  similarity = 0
  sport_suggestion = ""
  # iterates through each regular expression option

  sports_reg_exp.each do |sport, reg_exp|
    #hashmap to numerize the similarity
    count = Hash.new 0
    # hits on matches and adds to hash the size of the match
    input.scan(reg_exp).each {|elm| count[elm.length] += 1}
    temp_similarity = 0;
    count.each do |k,v|
      # longer matches are given more weight in the sum
      count[k] = k ** v
      temp_similarity += count[k]
    end
    # identifies the most similar spot
    if temp_similarity > similarity
      sport_suggestion = sport
      similarity = temp_similarity
    elsif temp_similarity == similarity
      # returns different sports for mistyped input
      sport_suggestion = sport if rand(0..1) == 1
    end
  end
  # returns empty string if not similar enough
  sport_suggestion = "" if (similarity == 1 || (similarity <= 3 && sport_suggestion.length > 15))
  sport_suggestion
end

# Created 10/05/2019 by Sharon Qiu
# Checks if a keyword is valid.
# Valid keywords only contain words or digits that do not end in punctuation. They are also strictly greater than a length of 2.
# Letters and numbers can be mixed to form a keyword.
def kw_validity? (keywords)
  valid = true
  kw_pattern = Regexp.new /^([[:alpha:]]+|\d+)[[:punct:]]?([[:alpha:]]+|\d+)$/
  keywords.each do |kw|
    valid = false unless kw =~ kw_pattern && kw.length > 2
  end
  valid
end

# Created 10/05/2019 by Sharon Qiu
# Checks if a keyword is in the article title.
# This is a STRICT query. The regex will match UP TO the word.
# It will not match the closest word found.
def article_match? (query, article_title)
  found = false
  return true if query.empty?
  temp_article = article_title.downcase
  query.each do |kw|
    pattern = Regexp.new /.*#{kw.downcase}.*/
    found = true if temp_article =~ pattern
  end
  found
end

# Created 09/26/2019 by Neel Mansukhani
def is_valid_email? email
  return email.match /[a-zA-Z]+\.[1-9]\d*@(buckeyemail\.)?osu\.edu/
end

# Created 10/06/2019 by Neel Manukhani
def is_used_username? username
  hash = JSON.load File.new 'user_information/user_data.json'
  hash.each_key do |u|
    return true if u == username
  end
  false
end
# Created 10/06/2019 by Leah Gillespie
# gets valid 4-digit year
def get_year
  valid_yr = false
  while !valid_yr
    print "Please enter the year you would like statistics for: "
    user_year = gets.chomp
    yr_reg_ex = Regexp.new /^[1-9]\d\d\d$/
    if user_year =~ yr_reg_ex
      valid_yr = true
    else
      puts "Sorry, that doesn't look like a valid year."
    end
  end
  return user_year.to_i
end

# Created 10/06/2019 by Leah Gillespie
# updates statistics
def get_stats (stats)
  if stats.season_exists
    stats.update_stats
    stats.display
  else
    puts "There are no recorded statistics for that season."
  end
end

# Created 10/06/2019 by Neel Mansukhani
# Gives our email authorization to use Google's api
def authorize
  client_id = Google::Auth::ClientId.from_file CREDENTIALS_PATH
  token_store = Google::Auth::Stores::FileTokenStore.new file: TOKEN_PATH
  authorizer = Google::Auth::UserAuthorizer.new client_id, SCOPE, token_store
  user_id = "default"
  credentials = authorizer.get_credentials user_id
  if credentials.nil?
    url = authorizer.get_authorization_url base_url: OOB_URI
    puts "Open the following URL in the browser and enter the " \
         "resulting code after authorization:\n" + url
    code = gets
    credentials = authorizer.get_and_store_credentials_from_code(
        user_id: user_id, code: code, base_url: OOB_URI
    )
  end
  credentials
end
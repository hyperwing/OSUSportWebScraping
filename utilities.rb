# File Created 09/26/2019 by Neel Mansukhani
# Edited 10/04/2019 by Sri Ramya Dandu

# Created 10/04/2019 by Sri Ramya Dandu
# Outputs a list of all the sports options
def list_sports(sports_reg_ex)
  puts "\nHere is the list of OSU sports with free parking, free admission, and free fun!"
  i = 0
  sports_reg_ex.each_key do |sport|
    puts if i % 4 == 0
    print sport
    (25 - sport.length).times do
      print " "
    end
    i += 1
  end
  puts
  puts
end

# Created 10/04/2019 by Sri Ramya Dandu
# Obtains a valid sports choice
def get_sport_choice(sports_reg_ex)
  print "Please enter the full name of a sport you would like information about:"
  sport = gets.chomp
  while !sports_reg_ex.has_key? sport
    sport_suggestion  = auto_suggest sport, sports_reg_ex

    if sport_suggestion != ""
      if (yes_no_input "Did you mean #{sport_suggestion}? (Y/N): ") == "Y"
        sport = sport_suggestion
      else
        list_sports sports_reg_ex if (yes_no_input "Would you like to see the list of sports again?") == "Y"

        print "Please enter the full name of a sport you would like information about:"
        sport = gets.chomp
      end
    else
      puts "Couldn't identify a sport!"
      list_sports sports_reg_ex if (yes_no_input "Would you like to see the list of sports again?") == "Y"
      print "Please enter the full name of a sport you would like information about:"
      sport = gets.chomp
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
    sport_regexp = sport_regexp + "|" + %Q*#{sport_chars[i]}#{sport_chars[i + 1]}#{sport_chars[i + 2]}#{sport_chars[i+3]}* if i < sport.length - 3
    sport_regexp = sport_regexp + "|" + "#{sport_chars[i]}#{sport_chars[i + 1]}#{sport_chars[i + 2]}" if i < sport.length - 2
    sport_regexp = sport_regexp + "|" + "#{sport_chars[i]}#{sport_chars[i + 1]}" if i < sport.length - 1
    sport_regexp = sport_regexp + "|" + "#{sport_chars[i]}" if i < sport.length
  end
  Regexp.new sport_regexp[1, sport_regexp.length]
end

# Created 09/28/2019 by Sri Ramya Dandu
# Edited 09/29/2019 by Sri Ramya Dandu: changed input to return a hash instead
# Returns a hashmap: key = sport, value = regular expression to identify sport
def sport_reg_exp (all_schedules)
  reg_exp_sports = Hash.new
  all_schedules[0].each do |current|
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
      sport_suggestion = sport if rand(0..1) == 1
    end
  end

  sport_suggestion = "" if (similarity == 1 || (similarity <= 3 && sport_suggestion.length > 15))
  sport_suggestion
end

# Created 09/26/2019 by Neel Mansukhani
def isValidEmail? email
  return true # TODO: Create Regex
end

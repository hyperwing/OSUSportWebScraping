# Project 3
### Web Scraping
This program scrapes the following website: https://ohiostatebuckeyes.com/bucks-on-us/. This website provides infromation about all the sports with free parking, free admission, free fun. 

The program scrapes data from each of the sports page and provides the following functionality:
1. Provides schedule, news, and stats info for sports
2. Allows user to save their information to recieve daily emails about their chosen sports
3. Key word querying over news articles for wanted sports 
4. Auto suggestion for wrong sports input 

### Roles
* Overall Project Manager: David Wing
* Coding Manager: Leah Gillespie
* Documentation Manager: Sri Ramya Dandu
* Testing: Neel Mansukhani

### Contributions
Please list who did what for each part of the project.
Also list if people worked together (pair programmed) on a particular section.

David Wing
* Parsing past seasons and gathering season stats
* Setting up cron job for emails 

Sri Ramya Dandu
* Parse the schedules for different sports to find the date, opponent, score, and if the game is home or away
* Auto correct functionality for sports for incorrect input 

Leah Gillespie
* User interface (accepting user input, displaying information)
* Creating data structures for parsed data to be used in search
* Caching all of the sports page

Neel Mansukhani
* Setting up back end to store user data
* Saving all user data to JSON file 
* Sending the emails

Sharon Qiu
* Parsing each sport's news feed, including date, team, headline, and URL
* Key work search functionality for the news article 

### How to run the project 
1. Installation:
> bundle install
>gem install whenever
https://github.com/javan/whenever

2. In the project directory, run the web_scraping.rb file to run the project.

### How to run tests
Run the following command in terminal in the project directory
>rspec testing/test_utilities.rb testing/test_info_scrape.rb testing/test_past_season_scrape.rb


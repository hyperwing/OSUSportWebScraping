# file created by David Wing 10/05/2019
# edited by David Wing 10/06/2019

# Use this file to easily define all of your cron jobs.

time = Time.new

set :output, "cron_log/"+time.day+"-"+time.month+".log"
# check user preferences to get timing for email

# For each user pref file

user = ""

timing = 30.seconds

every timing do 
    runner "send_email.send_email(" + user + ")"
end

#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

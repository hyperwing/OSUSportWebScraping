# File created 10/06/2019 by David Wing
# Sets the cron jobs for the emails

require 'json'

def set_cron_job

    # For each user pref file
    users = JSON.parse File.read "user_information/user_data.json"
    users.each do |user_json|
        

        user_json.each do |user_info|
            
            next if !user_info['email']
            next if !user_info['subscription'] 

            system("crontab -l > mycron")

            case user_info["subscription"]
            when "daily"    
                system("echo \"MAILTO=\""+user_info['email']+ "\"\n0 0 12 * * ? ruby createCronJob.rb\" >>mycron")
            when "weekly"
                system("echo \"MAILTO=\""+user_info['email']+ "\"\n0 0 12 * * SAT ruby createCronJob.rb\" >>mycron")
            when "monthly"
                system("echo \"MAILTO=\""+user_info['email']+ "\"\n0 0 12 1 * ? ruby createCronJob.rb\" >>mycron")
            end    

            system("crontab mycron")
            system("rm mycron")
        end
    end
end
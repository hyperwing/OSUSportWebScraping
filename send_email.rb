require 'net/smtp'


def send_email(username)

    # TODO get recipient email from file
    recipient_email = "test@test.com"

    our_email = "sportScrape@test.com"

    # get message from file

    message = 'From: Sport Digest <' + our_email+'>\n'
    message += 'To: '+ username +"<"+ recipient_email+'>\n'
    message += 'Subject: Sport digest for today'
    message += "body"
    

    Net::SMTP.start('localhost') do |smtp|
        smtp.send_message message, our_email, recipient_email
    end
end
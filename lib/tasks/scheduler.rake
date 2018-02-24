desc "This task is called by the Heroku scheduler add-on"

def send_reminders
  puts "Sending out email reminders for holidays."
  User.holiday_reminder
  puts "Emails sent!"
end

def send_feedback
  puts "Requesting feedback"
  User.feedback_request_reminder
  puts "Emails sent!"
end

task :cron => :environment do
  send_reminders
  send_feedback
end
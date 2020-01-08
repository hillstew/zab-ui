desc "Send user absence reminders"
task :send_reminders => :environment do # :environment will load our Rails app, so we can query the database with ActiveRecord
  users = User.all
  users.each do |user|
    ReminderSenderJob.perform_later(user) if (DateTime.now - user.last_login.to_date).to_i >= 15
  end
end

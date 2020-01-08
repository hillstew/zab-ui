class UserReminderMailer < ApplicationMailer
  def send_reminder(user)
    mail(to: user.email, subject: "#{user.first_name}, this is a reminder from ZAB")
  end
end

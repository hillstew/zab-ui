class UserReminderMailer < ApplicationMailer
  def send_reminder(user)
    @user = user
    mail(to: @user.email, subject: "#{@user.first_name}, a quick reminder from ZAB")
  end
end

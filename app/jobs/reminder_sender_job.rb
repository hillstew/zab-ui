class ReminderSenderJob < ApplicationJob
  queue_as :default

  def perform(user)
    UserReminderMailer.send_reminder(user).deliver_now
  end
end

require "rails_helper"

RSpec.describe UserReminderMailer, type: :mailer do
  it 'sends reminder emails to users' do
    user = create(:user, first_name: 'Bob', last_name: 'G', email: 'bob@gmail.com')
    mail = UserReminderMailer.send_reminder(user)

    expect(mail.subject).to eq("#{user.first_name}, a quick reminder from ZAB")
    expect(mail.to).to eq([user.email])
    expect(mail.from).to eq(['no-reply@zeroandbeyond.herokuapp.com'])
  end
end

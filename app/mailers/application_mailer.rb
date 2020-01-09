class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@zeroandbeyond.herokuapp.com'
  layout 'mailer'
end

class ApplicationMailer < ActionMailer::Base
  default from: ENV["RUNA_MAIL"]
  layout "mailer"
end

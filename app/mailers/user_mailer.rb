class UserMailer < ActionMailer::Base
  default from: ENV["AGENCYBOX_DEFAULT_FROM"]
end

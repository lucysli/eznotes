class UserMailer < ActionMailer::Base
  default from: "mcgill.osd.eznotes@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail to: user.email, subject: "Password Reset"
  end

  def new_registration(user)
    @user = user

    mail to: user.email, subject: "New Registration[McGill OSD EZnotes]"
  end

  def assign_notetaker(notetaker, course)
    @notetaker = notetaker
    @course = course

    mail to: notetaker.email, subject: "You Have Been Matched[McGill OSD EZnotes]"

  end

  def notify_users(user, course)
    @user = user
    @course = course

    mail to: user.email, subject: "You Have Been Matched[McGill OSD EZnotes]"
  end
end

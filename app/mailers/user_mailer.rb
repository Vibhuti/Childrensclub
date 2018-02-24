class UserMailer < ActionMailer::Base
  default from: "info@loveandlaughterplayschool.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_confirmation.subject
  #
  def account_confirmation user
    @user = user
    mail to: user.email, subject: "Welcome to Love And Laughter Playschool."
  end

  def send_digest user, message
    @user = user
    @content = message.content
    mail(to: user.email, subject: "[Love & Laughter Playschool ] #{message.title}")
  end

  def remind_holiday user, holiday_name, holiday_date
    mail(to: user.email, subject: holiday_name + " is holiday! " + "date is " + holiday_date.to_s)
  end

  def request_feedback user_id
    puts User.find(user_id).email
    mail(to: User.find(user_id).email, subject: "[Love & Laughter Playschool] Feedback Request")
  end
end

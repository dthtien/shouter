class UserMailer < ApplicationMailer
  def send_greeting_mail(user_id)
    @user = User.find(user_id)

    mail(
      to: @user.email,
      subject: 'Wellcome to shouter'
    )
  end
end

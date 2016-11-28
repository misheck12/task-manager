class SignupMailer < ApplicationMailer
  def confirm_email(user)
    @user = user
    @confirmation_link = confirmation_url({
        locale: I18n.locale,
        token: @user.confirmation_token
      })

    mail({
      to: user.email,
      subject: I18n.t('signup_mailer.confirm_email.subject')
      })
  end

end

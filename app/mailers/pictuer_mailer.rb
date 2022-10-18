class PictuerMailer < ApplicationMailer
  def post_mail(picture,user)
    @picture = picture
    @user = user
    mail to: @user.email, subject: "投稿確認メール"
  end
end

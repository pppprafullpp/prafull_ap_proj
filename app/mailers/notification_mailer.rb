class NotificationMailer < ApplicationMailer

  def welcome_mail (type,id)
    @user = eval(type.titleize).find(id)
    activation_token = @user.token
    @link = "http://103.243.5.242:4000/activate?type=#{type}&id=#{id}&token=#{activation_token}"
    subject = "Welcome to Social Booker"
    mail(:to=>@user.email,:subject=>subject).deliver!
  end
end

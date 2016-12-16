class UserMailer < ApplicationMailer
  default from: "welcomecommittee@crudcrud.com"
  # after_action :explore_email

  def welcome(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to CrudCrud!')
  end

  private
  def explore_email
    binding.pry
  end
end

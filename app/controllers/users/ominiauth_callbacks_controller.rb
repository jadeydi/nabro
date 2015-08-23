class Users::OminiauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    p request.env["omniauth.auth"]
    redirect_to root_url
  end
end

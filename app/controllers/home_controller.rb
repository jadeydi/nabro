class HomeController < ApplicationController
  def index
    if current_user && Time.now.utc.to_date <= current_user.last_clicked_at.to_date
      @try = current_user.last_try
    else
      @try = nil
    end
  end
end

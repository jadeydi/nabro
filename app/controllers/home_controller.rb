class HomeController < ApplicationController
  layout 'visitor'
  def index
    @task = current_user.tasks.where(status: 0).last if current_user
  end
end

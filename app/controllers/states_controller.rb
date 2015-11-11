class StatesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Time.now.utc.to_date > current_user.last_clicked_at.to_date
      if (last = State.last).present?
        last.update_attribute(:ended_at, Time.now)
      end
      current_user.states.create && current_user.update_last_clicked_at
    end
    redirect_to root_url, notice: I18n.t("site.prompt.already_clicked")
  end
end

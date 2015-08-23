class MoodsController < ApplicationController
  def create
    if current_user.present? && Time.now.utc.to_date > current_user.last_clicked_at.to_date
      Mood.last.update_attribute(:ended_at, Time.now)
      current_user.moods.create && current_user.update_last_clicked_at
    end
    redirect_to root_url
  end
end

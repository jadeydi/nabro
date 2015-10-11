module ApplicationHelper
  def last_clicked_at
    current_user.blank? ? "" : current_user.last_clicked_at.beginning_of_day.to_i
  end
end

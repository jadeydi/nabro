module ApplicationHelper
  def last_clicked_at
    current_user.blank? ? "" : current_user.last_clicked_at.beginning_of_day.to_i
  end

  def attempt_type(ua)
    type = case ua.status
    when 'fresh'
      "创建了"
    when 'done'
      "接受"
    when 'discard'
      "放弃"
    else
      "刷到了"
    end
    type + "任务"
  end
end

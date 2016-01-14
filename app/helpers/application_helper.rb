module ApplicationHelper
  def last_clicked_at
    current_user.blank? ? "" : current_user.last_clicked_at.beginning_of_day.to_i
  end

  def attempt_type(ua)
    case ua.status
    when 'done'
      "完成"
    when 'discard'
      "放弃"
    else
      "刷到了"
    end

  end
end

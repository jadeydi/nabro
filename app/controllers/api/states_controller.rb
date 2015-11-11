class Api::StatesController < Api::BaseController
  before_action :authenticate_user!

  def create
    if Time.now.utc.to_date > current_user.last_clicked_at.to_date
      if (last = State.last).present?
        last.update_attribute(ended_at: Time.now)
      end
      if current_user.states.create && current_user.update_last_clicked_at
        render json: {success: "update success"}, status: :created
      end
    end
    render json: {error: "failue"}, status: :not_acceptable
  end

end

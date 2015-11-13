class Api::StatesController < Api::BaseController
  before_action :authenticate_user!

  def create
    if Time.now.utc.to_date > current_user.last_clicked_at.to_date
      last.update_attributes(ended_at: Time.now) if (last = State.last).present?

      if current_user.states.create && current_user.update_last_clicked_at
        render json: {success: "update success"}, status: :created
      else
        render json: {error: "failue"}, status: :not_acceptable
      end
    else
      render json: {error: "Already clicked"}, status: :created
    end
  end

end

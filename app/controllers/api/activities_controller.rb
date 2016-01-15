class Api::ActivitiesController < Api::BaseController
  def index
    @activities = Activity.includes([:user, :target]).order(updated_at: :desc).limit(50)

    render json: @activities
  end
end

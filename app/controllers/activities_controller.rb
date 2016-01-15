class ActivitiesController < ApplicationController
  def index
    @activities = Activity.includes([:user, :target]).order(updated_at: :desc).limit(50)
  end
end

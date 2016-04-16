class ActivitiesController < ApplicationController
  def index
    @tasks = Task.quality.includes([:user]).order(created_at: :desc).limit(50)
  end
end

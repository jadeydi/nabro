class ActivitiesController < ApplicationController
  def index
    @tasks = Task.includes([:user]).order(created_at: :desc).limit(50)
  end
end

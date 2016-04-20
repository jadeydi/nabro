class HomeController < ApplicationController
  layout 'visitor'
  def index
    @count = Task.count
  end
end

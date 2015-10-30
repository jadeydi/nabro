class HomeController < ApplicationController
  def index
    @feeling = Feeling.last
  end
end

class HomeController < ApplicationController
  def index
    @mood = Mood.last
  end
end

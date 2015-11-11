class HomeController < ApplicationController
  def index
    @state = State.last
  end
end

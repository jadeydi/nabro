class PagesController < ApplicationController
  def show
    render file: Rails.public_path.join("about.html")
  end
end

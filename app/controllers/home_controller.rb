class HomeController < ApplicationController
  def index
    respond_to do |formato|
      formato.html
    end
  end
end

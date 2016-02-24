class WelcomeController < ApplicationController
  def index
    @events = Event.where(year: 1991)
  end

  def songs
    @songs = Song.all
  end
end

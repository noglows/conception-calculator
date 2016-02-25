class WelcomeController < ApplicationController
  def index
    @events = Event.all
  end

  def songs
    @songs = Song.all
  end
end

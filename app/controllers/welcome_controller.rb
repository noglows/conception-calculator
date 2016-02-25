class WelcomeController < ApplicationController
  def index
  end

  def events
    @events = Event.all
  end

  def songs
    @songs = Song.all
  end

  def movies
    @movies = Movie.all
  end
end

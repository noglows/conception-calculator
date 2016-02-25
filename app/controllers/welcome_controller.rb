class WelcomeController < ApplicationController
  def index
    @events = Event.all
  end

  def songs
    @songs = Song.all
  end

  def movies
    @movies = Movie.all
  end
end

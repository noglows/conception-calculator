class WelcomeController < ApplicationController
  def index
  end

  def events
    @events = Event.where(:year.gte => 2001)
    #:founded.gte => "1980-1-1"
  end

  def songs
    @songs = Song.all
  end

  def movies
    @movies = Movie.all
  end
end

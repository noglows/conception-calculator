class WelcomeController < ApplicationController
  def index
  end

  def events
    @events = Event.where(year: 2001, month: "September", day:11)
  end

  def songs
    @songs = Song.all
  end

  def movies
    @movies = Movie.all
  end
end

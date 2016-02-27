class ApiController < ApplicationController

  def events_for_day
    respond_to do |format|
      format.json do
        start_date = params[:start]
        month, day, year = ApiController.helpers.date_splitter(start_date)
        events = Event.where(year: year, month: month, day: day)
        render json: [events]
      end
    end
  end

  def songs_for_day
    respond_to do |format|
      format.json do
        start_date = params[:start]
        month, day, year = ApiController.helpers.date_splitter(start_date)
        events = Song.where(year: year, month: month, day: day)
        render json: [events]
      end
    end
  end

  def movie_for_day
    respond_to do |format|
      format.json do
        start_date = params[:start]
        month, day, year = ApiController.helpers.date_splitter(start_date)
        events = Movie.where(year: year, month: month, day: day)
        render json: [events]
      end
    end
  end

  def events_in_range
    respond_to do |format|
      format.json do
        start_date = params[:start]
        end_date = params[:end]
        start_month, start_day, start_year = ApiController.helpers.date_splitter(start_date)
        end_month, end_day, end_year = ApiController.helpers.date_splitter(end_date)
        events = Event.where(:year.gte => start_year, :year.lte => end_year)
        render json: [events]
      end
    end
  end

  #@events = Event.where(:year.gte => 2001)

end

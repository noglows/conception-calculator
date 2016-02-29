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

        start_date = Date.new(start_year, start_month, start_day)
        end_date = Date.new(end_year, end_month, end_day)
        date_range = ApiController.helpers.create_range(start_date, end_date)
        events = []
        date_range.each do |date|
          date_comp = date.split("-")
          events.push(Event.where(year: date_comp[0].to_i, month: date_comp[1].to_i, day: date_comp[2].to_i))
        end
        events.flatten!
        render json: [events]
      end
    end
  end

  #@events = Event.where(:year.gte => 2001)

end

class ApiController < ApplicationController

  def events_for_day
    respond_to do |format|
      format.json do
        start_date = params[:start]
        date = start_date.split("/")
        months = {"1" => "January", "2" => "February", "3" => "March", "4" => "April", "5" => "May", "6" => "June", "7" => "July", "8" => "August"}
        months["9"] = "September"
        months["10"] = "October"
        months["11"] = "November"
        months["12"] = "December"

        month = months[date[0]]
        day = date[1].to_i
        year = date[2].to_i
        events = Event.where(year: year, month: month, day: day)
        render json: [events]
      end
    end
  end

  def songs_for_day
    respond_to do |format|
      format.json do
        start_date = params[:start]
        date = start_date.split("/")
        months = {"1" => "January", "2" => "February", "3" => "March", "4" => "April", "5" => "May", "6" => "June", "7" => "July", "8" => "August"}
        months["9"] = "September"
        months["10"] = "October"
        months["11"] = "November"
        months["12"] = "December"

        month = months[date[0]]
        day = date[1].to_i
        year = date[2].to_i
        events = Song.where(year: year, month: month, day: day)
        render json: [events]
      end
    end
  end

  def movie_for_day
    respond_to do |format|
      format.json do
        start_date = params[:start]
        date = start_date.split("/")
        months = {"1" => "January", "2" => "February", "3" => "March", "4" => "April", "5" => "May", "6" => "June", "7" => "July", "8" => "August"}
        months["9"] = "September"
        months["10"] = "October"
        months["11"] = "November"
        months["12"] = "December"

        month = months[date[0]]
        day = date[1].to_i
        year = date[2].to_i
        events = Movie.where(year: year, month: month, day: day)
        render json: [events]
      end
    end
  end
end

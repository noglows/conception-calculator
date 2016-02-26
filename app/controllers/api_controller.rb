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
        day = date[1]
        year = date[2]
        binding.pry
        events = Event.where(year)
        render json: [month, day, year]
      end
    end
  end
end

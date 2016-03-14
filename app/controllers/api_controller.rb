class ApiController < ApplicationController

  def on_this_day
    respond_to do |format|
      format.json do
        event = ApiController.helpers.single_day_event(params[:type], params[:date])
        if event == nil
          event = []
        end
        if event.class != Array
          event = event.items
        end
        render json: event
      end
    end
  end

  def on_this_day_range
    respond_to do |format|
      format.json do
        events = ApiController.helpers.pull_events_in_range(params[:type], params[:start], params[:end])
        if events == nil
          events = []
        end
        render json: events
      end
    end
  end

  def conception_range
    respond_to do |format|
      format.json do
        if params[:unusual] == "true"
          number = params[:number].to_i
          number = number * 7
          modifier = params[:modifier]
        else
          number = 0
          modifier = nil
        end
        birth_month, birth_day, birth_year = ApiController.helpers.date_splitter(params[:birthday])
        begin
          birthdate = Date.new(birth_year, birth_month, birth_day)
          conception_date = birthdate - 266
          if number != 0
            if modifier.downcase == "early"
              conception_date += number
            elsif modifier.downcase == "late"
              conception_date -= number
            end
          end
          start_date = conception_date - 3
          end_date = conception_date + 3
          render json: [start_date, end_date]
        rescue
          render json: ["error" => false]
        end
      end
    end
  end

  # Want this method to take a search term and return the video id for the top result
  def get_youtube_id
    respond_to do |format|
      format.json do
        if params[:type] == "movie"
          search_term = params[:title] + " trailer"
        else
          search_term = params[:title] + " " + params[:artist]
        end
        headers = { "content-length" => "0", "user-agent" => "Yt::Request (gzip)" }
        query_hash = { maxResults: 1, q: search_term, type: "video", key: "AIzaSyDEuXqr2zOm0_Jp4U0nTrqdHr3cISNAI10", part: "snippet" }
        response = HTTParty.get("https://www.googleapis.com/youtube/v3/search", :query => query_hash, :headers => headers)
        render json: [response["items"][0]["id"]["videoId"]]
      end
    end
  end
end

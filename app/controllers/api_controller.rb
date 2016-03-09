class ApiController < ApplicationController

  def events_for_day
    respond_to do |format|
      format.json do
        event = ApiController.helpers.single_day_event(Event, params[:start])
        render json: event
      end
    end
  end

  def songs_for_day
    respond_to do |format|
      format.json do
        song = ApiController.helpers.single_day_event(Song, params[:start])
        render json: song.items[0]
      end
    end
  end

  def movie_for_day
    respond_to do |format|
      format.json do
        movie = ApiController.helpers.single_day_event(Movie, params[:start])
        render json: movie.items[0]
      end
    end
  end

  def events_in_range
    respond_to do |format|
      format.json do
        events = ApiController.helpers.pull_events_in_range(Event, params[:start], params[:end])
        render json: events
      end
    end
  end

  def movies_in_range
    respond_to do |format|
      format.json do
        movies = ApiController.helpers.pull_events_in_range(Movie, params[:start], params[:end])
        render json: movies
      end
    end
  end

  def songs_in_range
    respond_to do |format|
      format.json do
        songs = ApiController.helpers.pull_events_in_range(Song, params[:start], params[:end])
        render json: songs
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
        binding.pry
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

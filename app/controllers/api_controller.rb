class ApiController < ApplicationController

  def events_for_day
    respond_to do |format|
      format.json do
        start_date = params[:start]

        month, day, year = ApiController.helpers.date_splitter(start_date)
        dynamodb = Aws::DynamoDB::Client.new

        Aws.config.update({
           region: 'us-west-2',
           credentials: Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID"], ENV["AWS_SECRET_ACCESS_KEY"]),
         })

         dynamodb.scan :table_name => "events"

        a = Event.all
        binding.pry

        # params = {
        #   table_name: "Events",
        #   projection_expression: "#yr, month, day"
        #   key_condition_expression: "#yr = :yyyy and #mo = :",
        #   expression_attribute_names: {
        #       "#yr" => "year"
        #   },
        #   expression_attribute_values: {
        #       ":yyyy" => year
        #       "month"
        #   }
        # }

        #result = dynamodb.query(params)
        events = []
        result.items.each{|movie|
            events.push(event)
        }
        #response = dynamodb.scan(table_name: 'Events')
        #items = response.items

        #events = Event.where(year: year, month: month, day: day)
        render json: [events]
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
        # CANNOT GET API TO WORK - CERTIFICATE ERROR
        #https://www.youtube.com/watch?v=C_3d6GntKbk
        if params[:search].include? "trailer"
          response = 'XNcs9DrKYRU'
        else
          response = 'C_3d6GntKbk'
        end
        render json: [response]
      end
    end
  end
end

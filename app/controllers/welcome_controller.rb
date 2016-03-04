class WelcomeController < ApplicationController

  def index
  end

  def events
    @events = []
    dynamodb = Aws::DynamoDB::Client.new
    response = dynamodb.scan(table_name: 'Events_New')
    items = response.items
    binding.pry
    items.each do |item|
      @events.push(item)
    end
    @events.sort_by! { |hsh| [hsh["year"], hsh["month"], hsh["day"]] }
  end

  def songs
    @songs = []
    dynamodb = Aws::DynamoDB::Client.new

    response = dynamodb.scan(table_name: 'Songs')
    items = response.items
    items.each do |item|
      @songs.push(item)
    end
    @songs.sort_by! { |hsh| [hsh["year"], hsh["month"], hsh["day"]] }
  end

  def movies
    @movies = []
    dynamodb = Aws::DynamoDB::Client.new

    response = dynamodb.scan(table_name: 'XMYS_Movies')
    items = response.items
    items.each do |item|
      @movies.push(item)
    end
    binding.pry
    @movies.sort_by! { |hsh| [hsh["year"], hsh["month"], hsh["day"]] }
  end
end

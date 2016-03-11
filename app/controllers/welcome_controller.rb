class WelcomeController < ApplicationController

  def index
  end

  def test
  # Your logic here
  end

  def user_page
    @birthday = params[:id]
  end

  # def events
  #   @events = []
  #   dynamodb = Aws::DynamoDB::Client.new
  #   response = dynamodb.scan(table_name: 'XMYS_Events')
  #   items = response.items
  #   items.each do |item|
  #     @events.push(item)
  #   end
  #   @events.sort_by! { |hsh| [hsh["year"], hsh["month"], hsh["day"]] }
  # end
  #
  # def songs
  #   @songs = []
  #   dynamodb = Aws::DynamoDB::Client.new
  #
  #   response = dynamodb.scan(table_name: 'XMYS_Songs')
  #   items = response.items
  #   items.each do |item|
  #     @songs.push(item)
  #   end
  #   @songs.sort_by! { |hsh| [hsh["year"], hsh["month"], hsh["day"]] }
  # end
  #
  # def movies
  #   @movies = []
  #   dynamodb = Aws::DynamoDB::Client.new
  #
  #   response = dynamodb.scan(table_name: 'XMYS_Movies')
  #   items = response.items
  #   items.each do |item|
  #     @movies.push(item)
  #   end
  #   @movies.sort_by! { |hsh| [hsh["year"], hsh["month"], hsh["day"]] }
  # end

  def letsencrypt
    render plain: ENV['LE_AUTH_RESPONSE']
  end
end

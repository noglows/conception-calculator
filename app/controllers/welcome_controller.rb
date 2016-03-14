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

  def send_email
    person = params[:person]
    person.gsub!("\"","")
    sender = params[:sender]
    sender.gsub!("\"","")
    link = params[:message]
    link.gsub!("\"","")
    link = "https://www.xmarksyourstart.com/#{link}"
    html = '<html style="font-family:helvetica"> <h1> X Marks Your Start</h1><img width="200" height="200" src="cid:map_icon.png"> <br> <p> Your good friend ' + sender + ' wants you to know more about their conception.  Visit the link to learn more! </p> <a href=' + link + '> X Marks Your Start </a> <br></html>'

    begin
      RestClient.post "https://api:key-#{ENV["MAILGUN_API_KEY"]}"\
      "@api.mailgun.net/v3/xmarksyourstart.com/messages",
      :from => "X Marks Your Start <postmaster@xmarksyourstart.com>",
      #:to => "Jessica N <jessica.noglows@outlook.com>",
      :to => "<" + person + ">",
      :subject => "The story of #{sender}'s conception",
      :text => "Your good friend #{sender} wants you to know more about their conception.  Visit the below link to learn more!",
      #:html => '<html> <img width="200" height="200" src="cid:icon.png"> <br> <a href=' + link + '> X Marks Your Start </a> <br> <p> Your good friend ' + sender + ' wants you to know more about their conception.  Visit the link to learn more! </p>',
      :html => html,
      :inline => File.new(File.join("public", "map_icon.png"))
      render :json => [{"flash" => "Email successfully sent to #{person}"}]
    rescue
      render :json => [{"flash" => "Sorry, there's been an error."}]
    end

  end
end

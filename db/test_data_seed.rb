dynamodb = Aws::DynamoDB::Client.new

months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
months["November"] = 11
months["December"] = 12

# File.open("./wiki_test_data/test_movie_data.txt", "r").each do |line|
#   a = line.split(", ")
#   year = a[0].to_i
#   month = months[a[1]].to_i
#   day = a[2].to_i
#   title = a[3].gsub!("\n", "")
#
#   params = {
#     table_name: "Movies",
#     item: {
#       :_id => SecureRandom.uuid,
#       :year => year.to_f,
#       :month => month.to_f,
#       :day => day.to_f,
#       :title => title
#     }
#   }
#
#   begin
#     result = dynamodb.put_item(params)
#     puts "Added movie: #{year.to_i} #{month} #{day} - #{title}"
#   rescue  Aws::DynamoDB::Errors::ServiceError => error
#     puts "Unable to add movie:"
#     puts "#{error.message}"
#   end
# end

# music_csv = CSV.read("./wiki_test_data/test_music_data.csv")
# music_csv.each do |year, date, title, artist|
#   a = date.split(" ")
#   month = a[0]
#   day = a[1]
#   if title == nil
#     title = @prev_title
#   else
#     @prev_title = title
#   end
#   if artist == nil
#     artist = @prev_artist
#   else
#     @prev_artist = artist
#   end
#
#   params = {
#     table_name: "Songs",
#     item: {
#       :_id => SecureRandom.uuid,
#       :year => year.to_f,
#       :month => months[month].to_f,
#       :day => day.to_f,
#       :title => title,
#       :artist => artist
#     }
#   }
#
#   begin
#       result = dynamodb.put_item(params)
#       puts "Added song: #{year} #{month} #{day} - #{title} by #{artist}"
#
#   rescue  Aws::DynamoDB::Errors::ServiceError => error
#       puts "Unable to add movie:"
#       puts "#{error.message}"
#   end


File.open("./wiki_test_data/test_event_data.txt", "r").each do |line|
  a = line.split(", ")
  check = 3
  info = ""
  while (a[check] != "true") && (a[check] != "false")
    info += " "
    info += a[check]
    check += 1
  end
  if a[check] == "true"
    a[check] = true
  elsif a[check] == "false"
    a[check] = false
  end
  if a[check+1] == "true"
    a[check+1] = true
  elsif a[check+1] == "false"
    a[check+1] = false
  end

  if a[check+3] != nil
    a[check+3].slice!("\n")
  end

  params = {
    table_name: "Events",
    item: {
      :year => a[0].to_f,
      :
      :month => months[a[1]].to_f,
      :day => a[2].to_f,
      :info => info,
      :on_going => a[check],
      :is_range => a[check+1],
      :end_month => a[check+2],
      :end_day => a[check+3]
    }
  }
  begin
    result = dynamodb.put_item(params)
    puts "Added event: #{a[0].to_i} #{months[a[1]].to_i} #{a[2].to_i} - #{info}"
  rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to add event:"
    puts "#{error.message}"
  end
end

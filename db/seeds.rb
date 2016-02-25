# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# puts 'EMPTY THE MONGODB DATABASE'
# ::Mongoid::Sessions.default.drop
# years = (1902..2015).to_a
# years.each do |year|
#   File.open("./wiki_data/#{year}_ready.txt", "r").each do |line|
#     a = line.split(", ")
#     check = 3
#     info = ""
#     while (a[check] != "true") && (a[check] != "false")
#       info += " "
#       info += a[check]
#       check += 1
#     end
#     if a[check] == "true"
#       a[check] = true
#     elsif a[check] == "false"
#       a[check] = false
#     end
#     if a[check+1] == "true"
#       a[check+1] = true
#     elsif a[check+1] == "false"
#       a[check+1] = false
#     end
#
#     if a[check+3] != nil
#       a[check+3].slice!("\n")
#     end
#
#     event = Event.create! :year => a[0].to_i, :month => a[1], :day => a[2], :info => info, :on_going => a[check], :is_range => a[check+1], :end_month => a[check+2], :end_day => a[check+3]
#     puts "New event created: " << event.info
#     event.save
#   end
# end
#
# File.open("./wiki_data/error_file.txt", "r").each do |line|
#   a = line.split(", ")
#   check = 3
#   info = ""
#   while (a[check] != "true") && (a[check] != "false")
#     info += " "
#     info += a[check]
#     check += 1
#   end
#   if a[check] == "true"
#     a[check] = true
#   elsif a[check] == "false"
#     a[check] = false
#   end
#   if a[check+1] == "true"
#     a[check+1] = true
#   elsif a[check+1] == "false"
#     a[check+1] = false
#   end
#
#   if a[check+3] != nil
#     a[check+3].slice!("\n")
#   end
#
#   event = Event.create! :year => a[0].to_i, :month => a[1], :day => a[2], :info => info, :on_going => a[check], :is_range => a[check+1], :end_month => a[check+2], :end_day => a[check+3]
#   puts "Created error event " << event.info
#   event.save
# end
#music_years = (1940..2016).to_a
# years.each do |year|
#   File.open("./wiki_data/#{year}_ready.txt", "r").each do |line|

# music_csv = CSV.read("./wiki_data/all_music_data.csv")
# # Create a new market object for each row in the CSV
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
#   song = Song.create! :year => year.to_i, :month => month, :day => day, :title => title, :artist => artist
#   song.save
# end

File.open("./wiki_data/all_movies.txt", "r").each do |line|
  a = line.split(", ")
  year = a[0].to_i
  date = a[1].split(" ")
  if a[1] == "nil"
    month = @prev_month
    day = @prev_day
  else
    month = date[0]
    day = date[1].to_i
    @prev_month = month
    @prev_day = day
  end
  title = a[2]
  earned = a[5]
  earned.slice!("$")
  earned.gsub!(",", "")
  earned = earned.to_i

  movie = Movie.create! :year => year, :month => month, :day => day, :title => title, :earned => earned
  puts "Created movie " << movie.title
  movie.save
end

#end

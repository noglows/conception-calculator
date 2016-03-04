require "aws-sdk-core"
require "json"

# Aws.config.update({
#   region: "us-west-2",
#   endpoint: "http://localhost:8000"
# })
#
# dynamodb = Aws::DynamoDB::Client.new

# params = {
#     table_name: "Movies",
#     key_schema: [
#         {
#             attribute_name: "year",
#             key_type: "HASH"  #Partition key
#         },
#         {
#             attribute_name: "month",
#             key_type: "RANGE" #Sort key
#         }
#     ],
#     attribute_definitions: [
#         {
#             attribute_name: "year",
#             attribute_type: "N"
#         },
#         {
#             attribute_name: "month",
#             attribute_type: "N"
#         }
#
#     ],
#     provisioned_throughput: {
#         read_capacity_units: 10,
#         write_capacity_units: 10
#   }
# }
#
# begin
#     result = dynamodb.create_table(params)
#     puts "Created table. Status: " +
#         result.table_description.table_status;
#
# rescue  Aws::DynamoDB::Errors::ServiceError => error
#     puts "Unable to create table:"
#     puts "#{error.message}"
# end
#




# music_csv = CSV.read("./wiki_data/all_music_data.csv")
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
#   months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
#   months["November"] = 11
#   months["December"] = 12
#   song = Song.create! :year => year.to_i, :month => months[month].to_i, :day => day.to_i, :title => title, :artist => artist
#   song.save
# end

# File.open("./wiki_data/all_movies.txt", "r").each do |line|
#   a = line.split(", ")
#   year = a[0].to_i
#   date = a[1].split(" ")
#   if a[1] == "nil"
#     month = @prev_month
#     day = @prev_day
#   else
#     month = date[0]
#     day = date[1].to_i
#     @prev_month = month
#     @prev_day = day
#   end
#   title = a[2]
#   earned = a[5]
#   earned.slice!("$")
#   earned.gsub!(",", "")
#   earned = earned.to_i
#
#   months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
#   months["November"] = 11
#   months["December"] = 12
#
#   movie = Movie.create! :year => year.to_i, :month => months[month].to_i, :day => day.to_i, :title => title, :earned => earned
#   puts "Created movie " << movie.title
#   movie.save
# end
#
# Aws.config.update({
#   region: "us-west-2",
#   endpoint: "http://localhost:8000"
# })
#
# dynamodb = Aws::DynamoDB::Client.new
#
# tableName = 'Movies'
#
# #file = File.read('moviedata.json')
# #movies = JSON.parse(file)
# File.open("./wiki_data/movies_formatted.txt", "r").each do |line|
#   a = line.split(", ")
#
#   months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
#   months["November"] = 11
#   months["December"] = 12
#
#   year = a[0].to_i
#   month = months[a[1]]
#   day = a[2].to_i
#   title = a[3].gsub!("\n", "")
#
#     params = {
#         table_name: tableName,
#         item: {
#           :year => year,
#           :month => month,
#           :day => day,
#           :title => title
#         }
#     }
#
#     begin
#         result = dynamodb.put_item(params)
#         puts "Added movie: #{year} #{title}"
#
#     rescue  Aws::DynamoDB::Errors::ServiceError => error
#         puts "Unable to add movie:"
#         puts "#{error.message}"
#     end
# end

#File.open("./wiki_data/movies_formatted.txt", "r").each do |line|
#   a = line.split(", ")
#
#   months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
#   months["November"] = 11
#   months["December"] = 12
#
#   year = a[0].to_i
#   month = months[a[1]]
#   day = a[2].to_i
#   title = a[3].gsub!("\n", "")
#
#
#   movie = Movie.create! :year => year, :month => month, :day => day, :title => title
#   movie.save
# end

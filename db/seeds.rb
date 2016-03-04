dynamodb = Aws::DynamoDB::Client.new

# params = {
#     table_name: "XMYS_Songs",
#     key_schema: [
#         {
#             attribute_name: "year",
#             key_type: "HASH"  #Partition key
#         },
#         {
#             attribute_name: "sort",
#             key_type: "RANGE" #Sort key
#         }
#     ],
#     attribute_definitions: [
#         {
#             attribute_name: "year",
#             attribute_type: "N"
#         },
#         {
#             attribute_name: "sort",
#             attribute_type: "S"
#         },
#
#     ],
#     provisioned_throughput: {
#         read_capacity_units: 5,
#         write_capacity_units: 5
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
# sleep(45)

months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
months["November"] = 11
months["December"] = 12

music_csv = CSV.read("./wiki_test_data/test_music_data.csv")
music_csv.each do |year, date, title, artist|
  a = date.split(" ")
  month = a[0]
  day = a[1].to_i
  if title == nil
    title = @prev_title
  else
    @prev_title = title
  end
  if artist == nil
    artist = @prev_artist
  else
    @prev_artist = artist
  end

  month = months[month].to_i
  year = year.to_i

  code = ""
  code += year.to_s
  if month.to_s.length < 2
    code += "0"
  end
  code += month.to_s
  if day.to_s.length < 2
    code += "0"
  end
  code += day.to_s

  params = {
    table_name: "XMYS_Songs",
    item: {
      :year => year.to_f,
      :sort => code,
      :month => month.to_f,
      :day => day.to_f,
      :title => title,
      :artist => artist
    }
  }
  
  begin
    result = dynamodb.put_item(params)
    puts "Added movie: #{year.to_i} #{month} #{day} - #{title}"
  rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to add movie:"
    puts "#{error.message}"
  end
end

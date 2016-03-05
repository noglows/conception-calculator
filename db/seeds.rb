dynamodb = Aws::DynamoDB::Client.new

# params = {
#     table_name: "XMYS_Events",
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

# sleep(45)
#
months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
months["November"] = 11
months["December"] = 12


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

  months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
  months["November"] = 11
  months["December"] = 12

  code = ""
  code += a[0].to_s
  if months[a[1]].to_s.length < 2
    code += "0"
  end
  code += months[a[1]].to_s
  if a[2].to_s.length < 2
    code += "0"
  end
  code += a[2].to_s

  if (@prev_month == months[a[1]].to_i) && (@prev_day == a[2].to_i)
    code += @value.to_s
    @value += 1
  else
    code += "0"
    @value = 1
  end

  @prev_month = months[a[1]].to_i
  @prev_day = a[2].to_i


  params = {
    table_name: 'XMYS_Events',
    item: {
      :year => a[0].to_f,
      :sort => code,
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
    puts "Unable to add movie:"
    puts "#{error.message}"
  end
end

require "aws-sdk-core"
require "json"
require "securerandom"

Aws.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
})

dynamodb = Aws::DynamoDB::Client.new

params = {
    table_name: "Events"
}

begin
    result = dynamodb.delete_table(params)
    puts "Deleted table."

rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to delete table:"
    puts "#{error.message}"
end

params = {
    table_name: "Events",
    key_schema: [
        {
            attribute_name: "_id",
            key_type: "HASH"  #Partition key
        },
        {
            attribute_name: "year",
            key_type: "RANGE" #Sort key
        }
    ],
    attribute_definitions: [
        {
            attribute_name: "_id",
            attribute_type: "S"
        },
        {
            attribute_name: "year",
            attribute_type: "N"
        }

    ],
    provisioned_throughput: {
        read_capacity_units: 10,
        write_capacity_units: 10
  }
}

begin
    result = dynamodb.create_table(params)
    puts "Created table. Status: " +
        result.table_description.table_status;

rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to create table:"
    puts "#{error.message}"
end


tableName = 'Events'

years = (1902..2015).to_a
years.each do |year|
  File.open("./wiki_data/#{year}_ready.txt", "r").each do |line|
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
    params = {
      table_name: tableName,
      item: {
        :_id => SecureRandom.uuid,
        :year => a[0].to_f,
        :month => months[a[1]].to_f,
        :day => a[2].to_f,
        :info => info,
        :on_going => a[check],
        :is_range => a[check+1],
        :end_month => a[check+2],
        :end_day => a[check+3]
      }
    }
    binding.pry
    begin
        result = dynamodb.put_item(params)
        puts "Added event: #{a[0].to_i} #{months[a[1]].to_i} #{a[2].to_i} - #{info}"

    rescue  Aws::DynamoDB::Errors::ServiceError => error
        puts "Unable to add movie:"
        puts "#{error.message}"
    end
  end
end


File.open("./wiki_data/error_file.txt", "r").each do |line|
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

  params = {
    table_name: tableName,
    item: {
      :_id => SecureRandom.uuid,
      :year => a[0].to_i,
      :month => months[a[1]].to_i,
      :day => a[2].to_i,
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

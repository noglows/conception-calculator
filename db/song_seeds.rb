require "aws-sdk-core"
require "json"
require "securerandom"

Aws.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
})


dynamodb = Aws::DynamoDB::Client.new

params = {
    table_name: "Songs"
}

begin
    result = dynamodb.delete_table(params)
    puts "Deleted table."

rescue  Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to delete table:"
    puts "#{error.message}"
end

dynamodb = Aws::DynamoDB::Client.new

params = {
    table_name: "Songs",
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


tableName = 'Songs'

music_csv = CSV.read("./wiki_data/all_music_data.csv")
music_csv.each do |year, date, title, artist|
  a = date.split(" ")
  month = a[0]
  day = a[1]
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
  months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
  months["November"] = 11
  months["December"] = 12

  params = {
    table_name: tableName,
    item: {
      :_id => SecureRandom.uuid,
      :year => year.to_f,
      :month => months[month].to_f,
      :day => day.to_f,
      :title => title,
      :artist => artist
    }
  }

  begin
      result = dynamodb.put_item(params)
      puts "Added song: #{year} #{month} #{day} - #{title} by #{artist}"

  rescue  Aws::DynamoDB::Errors::ServiceError => error
      puts "Unable to add movie:"
      puts "#{error.message}"
  end
end

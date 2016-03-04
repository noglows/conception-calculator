require "aws-sdk-core"
require "json"
require "securerandom"

Aws.config.update({
  region: "us-west-2",
  endpoint: "http://localhost:8000"
})


dynamodb = Aws::DynamoDB::Client.new

params = {
    table_name: "Movies"
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
    table_name: "Movies",
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


tableName = 'Movies'

File.open("./wiki_data/movies_formatted.txt", "r").each do |line|
  a = line.split(", ")

  months = {"January" => 1, "February" => 2, "March" => 3, "April" => 4, "May" => 5, "June" => 6, "July" => 7, "August" => 8, "September" => 9, "October" => 10 }
  months["November"] = 11
  months["December"] = 12

  year = a[0].to_i
  month = months[a[1]].to_i
  day = a[2].to_i
  title = a[3].gsub!("\n", "")

  params = {
    table_name: tableName,
    item: {
      :_id => SecureRandom.uuid,
      :year => year.to_f,
      :month => month.to_f,
      :day => day.to_f,
      :title => title
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

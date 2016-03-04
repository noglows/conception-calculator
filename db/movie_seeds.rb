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

File.open("./wiki_test_data/test_movie_data.txt", "r").each do |line|
  a = line.split(", ")
  year = a[0].to_i
  month = months[a[1]].to_i
  day = a[2].to_i
  title = a[3].gsub!("\n", "")

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
    table_name: "XMYS_Movies",
    item: {
      :year => year.to_f,
      :sort => code,
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

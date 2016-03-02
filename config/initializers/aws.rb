
#require 'aws-sdk'

# AWS.config({
#    :access_key_id => ENV["AWS_ACCESS_KEY_ID"],
#    :secret_access_key => ENV["AWS_SECRET_ACCESS_KEY"],
#    :dynamo_db_endpoint => 'dynamodb.us-west-2.amazonaws.com'
#
#  })
#
#  binding.pry
#
#  Dynamoid.configure do |config|
#   config.adapter = 'aws_sdk' # This adapter establishes a connection to the DynamoDB servers using Amazon's own AWS gem.
#   config.namespace = "dynamoid_app_development" # To namespace tables created by Dynamoid from other tables you might have.
#   config.warn_on_scan = true # Output a warning to the logger when you perform a scan rather than a query on a table.
#   config.partitioning = true # Spread writes randomly across the database. See "partitioning" below for more.
#   config.partition_size = 200  # Determine the key space size that writes are randomly spread across.
#   config.read_capacity = 100 # Read capacity for your tables
#   config.write_capacity = 20 # Write capacity for your tables
# end
require 'aws-sdk'

Aws.config.update ({
  region: 'us-west-2',
})

# dynamoDB.tables.each do |t|
#   puts "Name:    #{t.name}"
#   puts "#Items:  #{t.item_count}"
# end

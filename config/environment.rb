# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Movies::Application.initialize!

AWS::S3::DEFAULT_HOST.replace "s3-website-us-west-2.amazonaws.com"

Rails.application.config.paperclip_defaults = {
  :storage => :s3,
  :s3_credentials => {
    # put your host name here if needed
    # see the reading below for more details
    :s3_host_name => "s3-us-west-1.amazonaws.com",
    :bucket => Rails.application.secrets.s3_bucket_name,
    :access_key_id => Rails.application.secrets.aws_access_key_id,
    :secret_access_key => Rails.application.secrets.aws_secret_access_key
  }
}
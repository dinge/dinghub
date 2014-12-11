PixabayClient.configure do |c|
  c.username  = Rails.application.secrets.pixabay["key"]
  c.key       = Rails.application.secrets.pixabay["secret"]
end

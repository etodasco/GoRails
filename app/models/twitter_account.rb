require "x"

  class TwitterAccount < ApplicationRecord
    has_many :tweets
    belongs_to :user
  
    validates :username, uniqueness: true
  
    def client
      x_credentials = {
        api_key:             Rails.application.credentials.dig(:twitter, :api_key),
        api_key_secret:      Rails.application.credentials.dig(:twitter, :api_secret),
        access_token:        token,
        access_token_secret: secret,
      }

    client = X::Client.new(**x_credentials)

    user_data = client.get("users/me")
    puts user_data

    post = client.post("tweets", { text: "Hello, World! (from @gem)" }.to_json)
    puts post

    tweet_id = post["data"]["id"]
    delete_response = client.delete("tweets/#{tweet_id}")
    puts delete_response
    end
  end

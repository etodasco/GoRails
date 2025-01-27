require "x"

class TwitterAccount < ApplicationRecord
  has_many :tweets
  belongs_to :user

  validates :username, uniqueness: true

  # Struct for language (if needed, though unused here)
  Language = Struct.new(:code, :name, :local_name, :status, :debug)

  def client
    X::Client.new(
      api_key:             Rails.application.credentials.dig(:twitter, :api_key),
      api_key_secret:      Rails.application.credentials.dig(:twitter, :api_secret),
      access_token:        token,
      access_token_secret: secret
    )
  end
end

class Tweet < ApplicationRecord
  belongs_to :twitter_account
  belongs_to :user

  validates :body, length: { in: 1..280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 24.hours.from_now
  end

  def published?
    tweet_id.present?
  end

  def publish_to_twitter!
    response = twitter_account.client.post("tweets", { text: body }.to_json)
    update(tweet_id: response["data"]["id"])
  rescue StandardError => e
    Rails.logger.error("Error publishing tweet: #{e.message}")
    errors.add(:base, "Failed to publish tweet: #{e.message}")
    false
  end
end


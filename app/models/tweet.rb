class Tweet < ApplicationRecord
  belongs_to :twitter_account
  belongs_to :user

  validates :body, length: { minimum:1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 24.hour.from_now
  end
end

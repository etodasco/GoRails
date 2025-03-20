class TweetsController < ApplicationController
    before_action :require_user_logged_in!
    before_action :set_tweet, only: [:edit, :update, :destroy]

    def require_user_logged_in!
        unless Current.user
          redirect_to sign_in_path, alert: "Please log in first."
        end
      end

    def index
        @tweets = Current.user.tweets
        @scheduled_posts = Tweet.where("publish_at > ?", Time.current)
        @past_posts = Tweet.where("publish_at <= ?", Time.current).order(publish_at: :desc)
    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Current.user.tweets.new(tweet_params)
        if @tweet.save
            redirect_to tweets_path, notice: "Tweet was scheduled successfully."
        else
            render :edit
        end
    end

    def destroy
        @tweet.destroy
        redirect_to tweets_path, notice: "Tweet was successfully unscheduled."
    end

    def edit
    end

    def update
        if @tweet.update(tweet_params)
        redirect_to tweets_path, notice: "Tweet was updated successfully."
        else
        end
    end

    private

    def tweet_params
        params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
    end

    def set_tweet
        @tweet = Current.user.tweets.find(params[:id])
    end
end
class TweetsController < ApplicationController
    def require_user_logged_in!
        unless Current.user
          redirect_to login_path, alert: "Please log in first."
        end
      end      

    def index
        @tweets = Current.user.tweets
    end

    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Current.user.tweets.new(tweet_params)
        if @tweet.save
            redirect_to tweets_path, notice: "Tweet was scheduled successfully"
        else
            render :new
        end
    end        

    private

    def tweet_params
        params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
    end    
end
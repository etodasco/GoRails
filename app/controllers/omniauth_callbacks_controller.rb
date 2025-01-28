class OmniauthCallbacksController < ApplicationController
    def twitter
      # Ensure the current user exists
      if Current.user.nil?
        redirect_to new_session_path, alert: "You must be logged in to connect your Twitter account." and return
      end
  
      # Find or initialize the Twitter account for the current user
      twitter_account = Current.user.twitter_accounts.where(username: auth.info.nickname).first_or_initialize
  
      # Update or create the Twitter account with the provided data
      if twitter_account.update(
        name: auth.info.name,
        image: auth.info.image,
        token: auth.credentials.token,
        secret: auth.credentials.secret
      )
        redirect_to twitter_accounts_path, notice: "Successfully connected to your Twitter account."
      else
        redirect_to twitter_accounts_path, alert: "There was an error connecting your Twitter account."
      end
    end
  
    private
  
    # Fetch the OmniAuth authentication info from the request
    def auth
      request.env['omniauth.auth']
    end
  end
  
class StaticController < ApplicationController
    def manifest
      render json: { name: "Sceduled Tweets", short_name: "App" }
    end
  end
  
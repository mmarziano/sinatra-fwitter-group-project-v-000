class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :'/tweets/index'
    else
      redirect '/login'
    end
  end

  


end

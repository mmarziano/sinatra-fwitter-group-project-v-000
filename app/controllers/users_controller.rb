class UsersController < ApplicationController
  configure do
    set :views, 'app/views'
  end

    get '/signup' do
      erb :'/users/signup'
    end

    post '/signup' do
      #binding.pry
      if User.find_by(username: params[:username])
        raise "Username already exists. Please log in instead."
      else
        @user = User.create(params)
      end
      @user.save
      @tweets = Tweet.all
      erb :"/tweets"
    end
end

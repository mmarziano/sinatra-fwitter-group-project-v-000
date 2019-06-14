class UsersController < ApplicationController
  configure do
    set :views, 'app/views'
  end

  get '/signup' do
    #binding.pry
    if !logged_in?
      erb :'/users/signup'
    else
      redirect to '/tweets'
    end
  end

  post '/signup' do
    #binding.pry
    if @user = User.find_by(username: params[:username])
      session[:user_id] = @user.id
      #raise "Username already exists. Try again."
    elsif params_present?
      @user = User.create(params)
      session[:user_id] = @user.id
    else
      return redirect to '/users/signup'
    end
    #binding.pry
    redirect to '/tweets'
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    if valid_login?
      @user = User.find_by(username: params[:username])
      session[:user_id] = @user.id
      @tweets = Tweet.all

    else
      redirect to '/login'
    end
    #binding.pry
    erb :'/tweets/index'
  end

  get '/logout' do
    session.clear

    erb :'/users/login'
  end
end

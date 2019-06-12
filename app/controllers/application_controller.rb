require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :'index'
  end

  get '/signup' do
    erb :'/users/signup'
  end

  post '/signup' do
    #binding.pry
    if User.find_by(username: params[:username])
      raise "Username already exists. Try again."
    else
      @user = User.create(params)
      session[:user_id] = @user.id
    end
    @tweets = Tweet.all
    #binding.pry
    erb :"/tweets/index"
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    #binding.pry
    erb :'/tweets/index'
  end

  get '/logout' do
    session.clear

    erb :'/login'
  end

helpers do
  def logged_in?
    !session[:user_id].nil?
  end

end

end

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
    if logged_in?
      redirect to "/tweets"
    end
      erb :'/users/signup'
  end

  post '/signup' do
    #binding.pry
    if User.find_by(username: params[:username])
      raise "Username already exists. Try again."
    elsif
      params_present?
      @user = User.create(params)
      session[:user_id] = @user.id
    else
      redirect to '/users/signup'
    end

    redirect to '/tweets'
  end

  get '/tweets' do
    @tweets = Tweet.all
    @user = current_user
    
    erb :'/tweets/index'
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

helpers do
  def logged_in?
    !!session[:user_id]
  end

  def current_user
    User.find(session[:user_id])
  end

  def params_present?
    params[:username].present? && params[:password].present? && params[:email].present?
  end

  def valid_login?
    user = User.find_by(username: params[:username])
    user.authenticate(params[:password])
  end

end

end

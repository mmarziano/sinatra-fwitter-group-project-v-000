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

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in? && params_present?
      Tweet.create(content: params[:content], user_id: current_user.id)
      redirect to '/users/:slugs'
    else
      redirect to '/tweets/new'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
    else
      redirect to '/login'
    end
    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
    else
      redirect to '/login'
    end
    erb :'/tweets/edit'
  end

  patch '/tweets' do
    binding.pry
  end
end

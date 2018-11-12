class TweetsController < ApplicationController



  get '/tweets/new' do

    if self.logged_in?
      @user = self.current_user
      erb :'tweets/new'
    else
      redirect "/login"
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if self.logged_in? && @tweet.user.id == self.current_user.id
      erb :"/tweets/edit_tweet"
    else
      redirect '/login'
    end
  end

  patch "/tweets/:id" do
    #binding.pry
    tweet = Tweet.find_by_id(params[:tweet_id])
    if self.logged_in? && tweet.user.id == self.current_user.id && params[:content] != ""
      #binding.pry
      tweet.update(content: params[:content])
      redirect "/tweets/#{tweet.id}"
    else
      redirect "/tweets/#{params[:tweet_id]}/edit"
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if self.logged_in? && @tweet.user.id == self.current_user.id
      erb :"/tweets/show_tweet"
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    if params[:content] != ""
      Tweet.create(content: params[:content], user_id: self.current_user.id)
      redirect :"users/#{self.current_user.id}"
    else
      redirect '/tweets/new'
    end
  end

  delete '/tweets/:id' do
    tweet = Tweet.find_by_id(params[:tweet_id])
    if self.logged_in? && tweet.user.id == self.current_user.id
      tweet.destroy
    else
      redirect "/tweets"
    end
  end

  get '/tweets' do
    if logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  helpers do
    def logged_in?
    !!session[:id]
    end

    def current_user
    User.find(session[:id])
    end
  end

end

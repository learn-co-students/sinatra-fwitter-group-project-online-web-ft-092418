class TweetsController < ApplicationController


  get '/tweets' do
    #binding.pry
    redirect to '/login' unless is_logged_in?(session)
    #redirect to '/login' unless !!session[:user_id]
    @user = current_user(session)
  #  @user = session[:user_id]
    @tweets = Tweet.all
  #  binding.pry
    erb :'/tweets/tweets'
  end

  post '/tweets' do

    if params[:content].empty?
      redirect "/tweets/new"
    else
      @tweet = current_user(session).tweets.create(content: params[:content])
  #    binding.pry
      redirect "/tweets/#{@tweet.id}"
    end
  end


  get '/tweets/new' do
    #  binding.pry
      redirect to '/login' unless is_logged_in?(session)
    #  binding.pry
      erb :'tweets/new'
  end

  get '/tweets/:id' do
  #  binding.pry
    @user = current_user(session)
    @tweet = Tweet.find_by_id(params[:id])
    #&& @user.id == @tweet.user.id
    if is_logged_in?(session) && @user.id == @tweet.user_id
  #    binding.pry
      erb :"/tweets/show" 

    else
#     binding.pry
      redirect '/login'
  #    erb :"/users/login"
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
  #  binding.pry
    if !params[:content].empty? && is_logged_in?(session)
    #  binding.pry
      @tweet.update(content: params[:content])
    else
    #  binding.pry
      redirect "/tweets/#{@tweet.id}/edit" if is_logged_in?(session)
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if is_logged_in?(session)
      @tweet = Tweet.find_by_id(params[:id])
    if session[:user_id]== @tweet.user_id
      #  binding.pry
        erb :"/tweets/edit"
      else
          redirect '/login'
      end
    else

      redirect '/login'
    end

  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
  #  binding.pry
  if session[:user_id]== @tweet.user_id && is_logged_in?(session)
  #  binding.pry
    @tweet.delete
    redirect '/tweets'
  else
  #  redirect '/tweets' if is_logged_in?(session)
    redirect '/login'
  end
  end



end

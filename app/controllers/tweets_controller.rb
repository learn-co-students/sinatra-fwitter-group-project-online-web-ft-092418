class TweetsController < ApplicationController

  get '/tweets' do
    @user = current_user
    erb :'/tweets/tweets'
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


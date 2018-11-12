require 'pry'
class UsersController < ApplicationController

  get '/users/:id' do
      
      @user = self.current_user
      erb :"users/show"
  end

  get '/index' do
    erb :index
  end

  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
    erb :'users/create_user'
    end
  end

  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
    if user.save && user.username != "" && user.email != ""
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    #binding.pry
   if !self.logged_in?
     erb :'users/login'
   else
     redirect "/tweets"
   end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if self.logged_in?
      session[:id] = nil
      redirect '/login'
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

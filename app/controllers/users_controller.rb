require 'pry'
class UsersController < ApplicationController

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
   
    erb :'users/login'
    
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

  helpers do
    def logged_in?
    !!session[:id]
    end
    
    def current_user
    User.find(session[:id])
    end
  end 

end

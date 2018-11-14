class UsersController < ApplicationController



get '/index' do
  erb :index

end


  get '/login' do
    #binding.pry
    redirect to '/tweets' if is_logged_in?(session)
    #binding.pry
    erb :'users/login'
  end

  post '/login' do
    user=User.find_by(username: params[:username])

    # && user.authenticate(params[:password])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
    #  binding.pry
      redirect to '/tweets'
    else

      redirect to '/login'
    end

  end

  get '/logout' do
    #binding.pry

    session[:user_id] = nil
  #  redirect to '/tweets' if is_logged_in?(session)
    redirect to '/login'
  end

  post '/signup' do

    redirect to '/signup' if params[:username].empty? || params[:email].empty? || params[:password].empty?
    #user = User.create(username: params[:username] , email: params[:email] , password_digest: params[:password] )
  #  binding.pry
    user =User.create(params)

  #  binding.pry
    session[:user_id] = user.id
    redirect to '/tweets'
  end



  get '/signup' do
    #binding.pry
    if is_logged_in?(session)
      redirect to '/tweets'
    else
      erb :'/users/create_user'
    end
  end

  get '/users/:slug' do
     @user = User.find_by_slug(params[:slug])
    # binding.pry
     erb :'/users/show'
  end


end

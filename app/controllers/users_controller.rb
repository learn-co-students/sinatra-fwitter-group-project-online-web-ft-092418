class UsersController < ApplicationController

    get '/signup' do
        redirect '/tweets' if logged_in?
        erb :'users/new'
    end

    post '/signup' do 
        @user = User.new(params)

        if @user.save  
            session["user_id"] =  @user.id
            redirect "/tweets"
        else
            session[:temp_errors] = @user.errors.full_messages
            redirect '/signup'
        end
    end

    # -------------------

    get '/login' do 
        redirect '/tweets' if logged_in?
        erb :'sessions/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            session["user_id"] = user.id
            redirect '/tweets'
        elsif user
            session[:temp_errors] = ["Invalid email or password"]
        end
        redirect '/login'
    end

    # -------------------


    get '/logout' do 
        logout!
        redirect '/login'
    end

    # -------------------
    # -------------------
    # -------------------
    # -----SHOW PAGE-----


    get '/users/:slug' do 
        @user = User.find_by(username: params[:slug])
        erb :'users/show'

    end


end
class TweetsController < ApplicationController
    get '/tweets' do
        redirect '/login' if !logged_in?
        @user = current_user
        @tweets = Tweet.all
        erb :'/tweets/index'
    end

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new' 
        else
            redirect '/login'
        end
    end

    post '/tweets' do 
        tweet = current_user.tweets.build(content: params[:content])
        
        if tweet.save
            redirect '/tweets'
        else
            session[:temp_errors] = tweet.errors.full_messages
            redirect '/tweets/new'
        end
    end

    get '/tweets/:id' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'/tweets/show'
        else
            redirect '/login'
        end
    end


    get '/tweets/:id/edit' do 
        if logged_in? 
            user = Tweet.find_by_id(params[:id]).user
            if user.id == current_user.id
                @tweet = Tweet.find_by_id(params[:id])
                erb :'/tweets/edit'
            else
                session[:temp_errors] = ["This tweet belongs to another user."]
                redirect '/tweets'
            end
        else
            session[:temp_errors] = ["You must be logged in to view that."]
            redirect "/login"
        end
    end

    patch '/tweets/:id' do 
        @tweet = Tweet.find_by_id(params[:id])
        params.delete("_method")
        if @tweet.update(params)
            redirect "/tweets/#{@tweet.id}"
        else
            session[:temp_errors] = @tweet.errors.full_messages
            redirect "/tweets/#{@tweet.id}/edit"
        end
    end

    delete '/tweets/:id' do 
        user = Tweet.find_by_id(params[:id]).user
        if current_user == user         
            @tweet = Tweet.find_by_id(params[:id])
            @tweet.destroy
            session[:temp_errors] = ["Your tweet was deleted successfully."]
            redirect '/tweets'
        else
            session[:temp_errors] = ["This tweet belongs to another user."]
            redirect '/tweets'
        end
    end
end

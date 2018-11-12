class TweetsController < ApplicationController
       
    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all 
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/tweets'
        else 
            redirect '/login'
        end
    end 

    get '/tweets/new' do
        if logged_in?
            erb :'tweets/new'
        else 
            redirect '/login'
        end
    end

    post '/tweets' do
        if logged_in?
            if params[:tweet][:content].empty?
                redirect '/tweets/new'
            else
                user = current_user
                user.tweets.create(content: params[:tweet][:content])
                user.save
                redirect '/tweets'
            end
        else 
            redirect '/login'
        end
    end

    get '/tweets/:id' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/show_tweet'
        else 
            redirect '/login'
        end
    end

    get '/tweets/:id/edit' do
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            erb :'tweets/edit_tweet'
        else 
            redirect '/login'
        end 
    end

    patch '/tweets/:id' do
        if logged_in?
            tweet = Tweet.find_by_id(params[:id])
            if params[:tweet][:content].empty?
                redirect "/tweets/#{tweet.id}/edit"
            else
                tweet.update(params[:tweet])
                tweet.save
                redirect "/tweets/#{tweet.id}"
            end
        else 
            redirect '/login'
        end          
    end

    delete '/tweets/:id/delete' do
        if logged_in?
            tweet = Tweet.find_by_id(params[:id])
            if tweet.user == current_user
                tweet.delete
                redirect '/tweets'
            else
                redirect '/tweets'
            end
        else 
            redirect '/login'
        end  
    end
end

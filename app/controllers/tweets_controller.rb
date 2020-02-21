class TweetsController < ApplicationController

    get '/tweets' do
        if is_logged_in?
          erb :'/tweets/index'
        else
          flash[:message] = "You need to login first to access this page."
          redirect to '/login'
        end
    end
    
    get '/tweets/new' do
        if is_logged_in?
          erb :'/tweets/new'
        else
          flash[:message] = "You need to login first to access this page."
          redirect to "/login"
        end
    end
    
    post '/tweets' do
        if is_logged_in?
          tweet = Tweet.new(params)
          tweet.user = current_user
          if tweet.save
            flash[:message] = "Tweet posted with success!"
            redirect to "/tweets/#{tweet.id}"
          else
            flash[:message] = "Please enter a valid tweet."
            redirect to "/tweets/new"
          end
        else
          flash[:message] = "You need to login first to access this page."
          redirect to "/login"
        end
    end

    get '/tweets/:id/edit' do
        if is_logged_in?
          @tweet = current_user.tweets.find_by_id(params[:id])
          if @tweet
            erb :'/tweets/edit'
          else
            flash[:message] = "Unable to edit this tweet since it doesn't belong to you."
            redirect to "/tweets"
          end
        else
          flash[:message] = "You need to login first to access this page."
          redirect to "/login"
        end
    end
    
    patch '/tweets/:id' do
        if is_logged_in?
          @tweet = current_user.tweets.find_by_id(params[:id])
          if @tweet
            @tweet.content = params[:content]
            if @tweet.save
              flash[:message] = "Your tweet has been updated with success!"
              redirect to "/tweets/#{@tweet.id}"
            else
              redirect to "/tweets/#{@tweet.id}/edit"
            end
          else
            redirect to "/tweets"
          end
        else
          flash[:message] = "You need to login first to access this page."
          redirect to "/login"
        end
    end
    
    get '/tweets/:id' do
        if is_logged_in?
          @tweet = Tweet.find_by_id(params[:id])
        if @tweet
            erb :'/tweets/show'
        else
            redirect to "/tweets"
        end
        else
          flash[:message] = "You need to login first to access this page."
          redirect to "/login"
        end
    end
    
    delete '/tweets/:id' do
        if is_logged_in?
          tweet = current_user.tweets.find_by_id(params[:id])
        if tweet
            tweet.delete
            flash[:message] = "The Tweet got deleted."
            redirect to "/tweets"
        else
            flash[:message] = "Unable to delete this tweet since it doesn't belong to you."
            redirect to "/tweets"
        end
        else
          flash[:message] = "You need to login first to access this page."
          redirect to "/login"
        end
    end

end

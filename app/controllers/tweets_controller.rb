class TweetsController < ApplicationController
  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @tweets = Tweet.all
      erb :'tweets/tweets'
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end


  post '/tweets' do
    if current_user
      if params[:content].empty?
        redirect '/tweets/new'
      end
      @tweet = Tweet.new(content: params[:content])
      @tweet.user_id = current_user.id
      if @tweet.save
        redirect "/tweets/#{@tweet.id}"
      else
        redirect "/tweets/new"
      end
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if !current_user
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if !current_user
      redirect '/login'
    else
      @tweet = Tweet.find_by(id: params[:id])
      erb :'tweets/edit'
    end
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if params[:content].empty?
      redirect to "/tweets/#{@tweet.id}/edit"
    else
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    end
  end

  delete '/tweets/:id' do
    @tweet = Tweet.find(params[:id])
    if current_user.id == @tweet.id
      @tweet.destroy
    else
      redirect '/tweets'
    end
  end

end

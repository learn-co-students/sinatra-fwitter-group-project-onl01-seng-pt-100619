class UsersController < ApplicationController

    get '/signup' do
      if !is_logged_in?
        erb :'/users/new'
      else
        redirect to "/tweets"
      end
    end
  
    post '/signup' do
      @user = User.new(params)
      if @user.save
        session[:user_id] = @user.id
        redirect to "/tweets"
      else
        flash[:message] = "Please enter valid information."
        redirect to "/signup"
      end
    end
  
    get '/users/:slug' do
      @user = User.find_by_slug(params[:slug])
      erb :'/users/show'
    end
  
    get '/login' do
      if is_logged_in?
        redirect "/tweets"
      else
        erb :login
      end
    end
  
    post '/login' do
      user = User.find_by(username:params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tweets"
      else
        flash[:message] = "Please enter valid login information."
        redirect "/login"
      end
    end
  
    get '/logout' do
      if is_logged_in?
        session.clear
        redirect to '/login'
      else
        redirect to '/'
      end
    end
end
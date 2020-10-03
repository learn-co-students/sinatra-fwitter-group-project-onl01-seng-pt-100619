class UsersController < ApplicationController

  get '/login' do
    current_user ? (redirect to '/tweets') : (erb :'users/login')
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect "/login"
    end
  end

  get '/signup' do
    !!logged_in? ? (redirect to '/tweets') : ( erb :'users/signup')
  end

  post '/signup' do
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.errors.any?
      redirect '/signup'
    elsif @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup' 
    end
  end
  get '/users/:id/:slug' do
    @user = User.find_by_slug(params[:slug].to_i)
    erb :'users/show'
  end

  get '/users/:id' do
    @user = User.find_by(id: params[:id].to_i)
    erb :'users/show'
  end
  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end
end

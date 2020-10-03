require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'secretissafe'
  end
  get '/' do
    logged_in? ? (redirect to '/tweets') : (erb :'users/main')
  end
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end
  end
end

require './config/environment'
require 'securerandom'
require 'sinatra/flash'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "980a08f4-fd19-4d2e-92a2-cef7187f124f"
  end

  get '/' do
    if !is_logged_in?
      erb :index
    else
      redirect "/tweets"
    end
  end

  helpers do
    def is_logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fwitter_secret"
  end
  get '/' do
    erb :index
  end


  helpers do
    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end
  post '/tweets' do

  end
  get '/tweets/:id' do
    erb :'tweets/show_tweet'
  end
  get '/tweets/:id/edit' do
    erb :'tweets/edit_tweet'
  end
  post '/tweets/:id' do

  end
  post 'tweets/:id/delete' do

  end
  get '/signup' do

    erb :'users/create_user'
  end
  post '/signup' do

  end

  get '/login' do

    erb :'users/login'
  end
  post '/login' do

  end
  get '/logout' do

  end
end

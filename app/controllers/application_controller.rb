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
get '/tweets' do
  if logged_in?
    @tweets = Tweet.all
    erb :'tweets/tweets'
  else
    redirect to '/login'

  end
end
  get '/tweets/new' do
    if logged_in?
      erb :'tweets/create_tweet'
    else
      redirect to '/login'
    end

  end
  post '/tweets' do
    if logged_in?
      if params[:content] == ""
        redirect to '/tweet/new'
      else
        @tweet = current_user.tweets.build(content: params[:content])
        if @tweet.save
          redirect to 'tweets/#{@tweet.id}'
        else
          redirect to "/tweet/new"
        end
      end
    else
      redirect to '/login'
    end

  end
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to 'login'
    end
  end
  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user === current_user
      erb :'tweets/edit_tweet'
      else
        redirect tio '/tweets'
      end
    else
      redirect to '/login'
    end
  end
  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          if @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect to '/tweets'
        end
      end
    else
      redirect to '/login'
    end

  end
  delete 'tweets/:id/delete' do
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
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

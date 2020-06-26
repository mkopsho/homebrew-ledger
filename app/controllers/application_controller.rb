require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'

    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    
    set :show_exceptions, false
    register Sinatra::Flash
  end

  not_found do
    @error = response.status
    erb :error
  end

  error 400..510 do
    @error = response.status
    erb :error
  end

  error ActiveRecord::RecordNotFound do
    redirect '/'
  end

  helpers do
    def logged_in?
      !!session[:user_id] # `!!` converts value to boolean.
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end

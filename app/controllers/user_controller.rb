class UsersController < ApplicationController
  # To do: Add 'show' route for personal homepage
  get '/' do
    if logged_in?
      redirect '/recipes'
    else
      erb :homepage
    end
  end

  get '/signup' do
    if logged_in?
      redirect '/recipes'
    else
      erb :'users/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/recipes'
    else
      erb :'users/login'
    end
  end

  post '/signup' do
    user = User.new(params)
    if user.save # false if this doesn't satisfy the validators defined in the `User` model
      session[:user_id] = user.id
      redirect '/recipes'
    else
      flash[:error] = "That username is unavailable, please try again."
      redirect '/signup'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/recipes'
    else
      flash[:error] = "Invalid credentials."
      redirect '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end
end
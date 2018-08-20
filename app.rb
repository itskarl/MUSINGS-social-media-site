require 'sinatra'
require 'sinatra/activerecord'
enable :sessions

set :database, "sqlite3:rumblr.sqlite3"

get '/' do
  p 'someone visited'
  @user = User.all
  p @users
  erb :home
end

get '/login' do
  erb :login
end

get '/account' do
  erb :account
end

get '/signup' do
  erb :signup
end

get '/home' do
  erb :home
end

get '/about' do
  erb :about
end

post '/signup' do
  p params

  user = User.new(
    email: params['email'],
    first_name: params['first_name'],
    last_name: params['last_name'],
    username: params['username'],
    password: params['password']
  )

  if user != nil
    user.save
  else
    p 'try again'
  end

  redirect '/account'
end

post '/login' do
  email = params['email']
  input_password = params['password']

  user =  User.find_by(email: email)
  if user.password == input_password
    session[:user] = user
    redirect :account
  else
    p "invalid login"
    redirect '/login'
  end
end

get '/logout' do
  session[:user] = nil
  p "user has logged out"
  erb :logout
end

get '/*' do
  erb :errorpage
end

require './models'

require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'faker'
enable :sessions

set :database, 'sqlite3:rumblr.sqlite3'

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
  @allposts = Post.all

  if !session[:user].nil?
    erb :account
  else
    erb :home
  end
end

get '/profile' do
  if !session[:user].nil?
    erb :profile
  else
    erb :login
  end
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

get '/deleteaccount' do
  erb :deleteaccount
end


post '/signup' do
  p params
  user = User.new(
    email: params['email'],
    first_name: params['first_name'],
    last_name: params['last_name'],
    username: params['username'],
    password: params['password'],
    birthday: params['birthday']
  )

  user.save

  if user != nil
    email = params['email']
    input_password = params['password']
    user = User.find_by(email: email)

      user.password == input_password
      session[:user] = user
      redirect '/account'
  else
    p 'error in signup'
  end

  rescue ActiveRecord::RecordNotUnique
  p 'Needs unique info'
  redirect '/signup'

end


post '/login' do
  email = params['email']
  input_password = params['password']

  user = User.find_by(email: email)
  unless user == nil
    if user.password == input_password
      session[:user] = user
      redirect :account
    else
      p 'invalid login'
      redirect '/login'
    end
  end
end

get '/logout' do
  session[:user] = nil
  p 'user has logged out'
  erb :logout
end

post '/account' do

  posting = Post.create(
    content: params[:content],
    creator: session[:user].username,
    image_url: params[:image_url],
    post_time: Time.now,
    user_id: session[:user].id
  )

  if !posting.nil?
    posting.save
  else
    p 'try again'
  end

  redirect '/account'
end

post '/deleteaccount' do
  User.find(session[:user].id).destroy
  p "USER #{session[:user].first_name} DELETED"
  session[:user] = nil
  redirect '/'
end

get '/muser/:id' do
  begin
    @muser = User.find(params[:id])
    @posts = @muser.posts
  rescue
    redirect '/'
  end
  erb :muser
end

get '/*' do
  erb :errorpage
end

require './models'

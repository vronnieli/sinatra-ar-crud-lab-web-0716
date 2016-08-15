require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do

  end

#Create
  get '/posts/new' do
    erb :new
  end

  post '/posts' do
    Post.create(name: params["name"], content: params["content"])
    redirect to '/posts'
  end

#Read
  get '/posts' do
    @posts = Post.all
    erb :index
  end

  get '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    erb :show
  end

#update

  get '/posts/:id/edit' do
    @post = Post.find_by_id(params[:id])
    erb :edit
  end

  patch '/posts/:id' do
    @post = Post.find_by_id(params[:id])
    @post.name = params["name"]
    @post.content = params["content"]
    @post.save
    redirect to "/posts/#{@post.id}"
  end

#delete

  delete '/posts/:id/delete' do
    @post = Post.find_by_id(params[:id])
    @post.destroy
    # flash[:notice] = "#{@post.name} was deleted"
    # redirect to '/posts'
    @posts = Post.all
    erb :index
  end

end

require 'sinatra'
require 'sequel'
require 'sqlite3'
require './models/post'
require './models/comment'

get '/' do
  erb :home
end

get '/write_post' do
  erb :write_post
end

get '/posts/:post_id' do
  @post = Post.find(params[:post_id])
  if @post.nil?
    redirect '/nopost'
  else
  erb :post
  end
end

get '/nopost' do
  erb :nopost
end

get '/archive' do
  erb :archive
end

post '/create_post' do
  new_post = Post.new(params[:author], params[:title], params[:post_body])
  new_post_db_row = new_post.create!
  new_post_id = new_post_db_row[:id]
  redirect "posts/#{new_post_id}"
end

get '/edit_post/:post_id' do
  @post = Post.find(params[:post_id])
  if @post.nil?
    redirect "/noposts/"
  else
  erb :edit_post
  end
end

put '/posts/:post_id' do
  @post = Post.find(params[:post_id])
  @post.update!(params[:post_id], params[:author], params[:title], params[:post_body])
  redirect "posts/#{params[:post_id]}"
end

delete '/posts/:post_id' do
  @post = Post.find(params[:post_id])
  @post.delete!(params[:post_id])
  redirect "/"
end

post '/posts/:post_id/create_comment' do
  new_comment = Comment.new(params[:author], params[:comment_body], params[:post_id])
  new_comment_db_row = new_comment.create!
  redirect "posts/#{params[:post_id]}"
end

get '/posts/:post_id/:comment_id' do
  @post = Post.find(params[:post_id])
  @comment = Comment.find(params[:comment_id])
  if @comment.nil?
    redirect "/noposts/"
  else
  erb :edit_comment
  end
end

put '/posts/:post_id/:comment_id' do
  @comment = Comment.find(params[:comment_id])
  @comment.update!(params[:comment_id], params[:author], params[:comment_body])
  redirect "posts/#{params[:post_id]}"
end

delete '/posts/:post_id/:comment_id' do
  @comment = Comment.find(params[:comment_id])
  @comment.delete!(params[:comment_id])
  redirect "posts/#{params[:post_id]}"
end

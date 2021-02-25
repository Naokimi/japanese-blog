class PostsController < ApplicationController
  def index
    @posts = ServerCaller.call('get', 'posts')['posts']
  end

  def show
    @post = ServerCaller.call('get', "posts/#{params[:id]}")
    @comments = ServerCaller.call('get', "posts/#{params[:id]}/comments")['comments']
  end

  def create
    response = ServerCaller.call('get', 'posts', params)
    if response.include?('errors:')
      render :new
    else
      redirect_to post_path
    end
  end

  def new; end
end

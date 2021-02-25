class PostsController < ApplicationController
  def index
    @posts = ServerCaller.call('get', 'posts')['posts']
  end

  def show
  end

  def create
  end

  def new
  end
end

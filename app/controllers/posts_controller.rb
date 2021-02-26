class PostsController < ApplicationController
  def index
    @posts = ServerCaller.call('get', 'posts')['posts']
  end

  def show
    @post = ServerCaller.call('get', "posts/#{params[:id]}")
    comments = ServerCaller.call('get', "posts/#{params[:id]}/comments")['comments']
    @comments = comments.sort_by { |hsh| hsh[:id] }.reverse
  end

  def create
    response = ServerCaller.call('post', 'posts', post_params)
    if response.include?('errors:')
      render :new
    else
      redirect_to posts_path
    end
  end

  def new; end

  private

  def post_params
    { post: params.require(:post).permit(:title, :body).to_h }
  end
end

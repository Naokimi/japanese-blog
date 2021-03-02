class PostsController < ApplicationController
  def index
    posts = ServerCaller.call('get', 'posts')['posts']
    @posts = posts ? posts.sort_by { |hsh| hsh[:id] }.reverse : []
  end

  def show
    @post = ServerCaller.call('get', "posts/#{params[:id]}")
    comments = ServerCaller.call('get', "posts/#{params[:id]}/comments")['comments']
    @comments = comments ? comments.sort_by { |hsh| hsh[:id] }.reverse : []
  end

  def create
    response = ServerCaller.call('post', 'posts', post_params)
    if response['errors']
      @errors = response['errors']
      render :new
    elsif response == {}
      @errors = ['Server not working']
      render :new
    else
      redirect_to post_path(response['id'])
    end
  end

  def new; end

  private

  def post_params
    { post: params.require(:post).permit(:title, :body).to_h }
  end
end

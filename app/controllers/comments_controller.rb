class CommentsController < ApplicationController
  def create
    ServerCaller.call('post', "posts/#{params[:post_id]}/comments", comment_params)
    redirect_to post_path(params[:post_id])
  end

  private

  def comment_params
    { comment: params.require(:comment).permit(:name, :body).to_h }
  end
end

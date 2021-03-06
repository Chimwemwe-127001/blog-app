class CommentsController < ApplicationController
  before_action :current_user, only: [:create]

  def create
    @comment = current_user.comments.new(comments_params)
    @comment.users_id = current_user.id
    @comment.post_id = params[:post_id]

    if @comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to user_post_path(current_user.id, Post.find(params[:post_id]))
    else
      render :new
      flash.now[:error] = 'Comment not saved'
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment deleted successfully'
    redirect_to user_post_path(current_user.id, Post.find(@comment.post_id))
  end

  def comments_params
    params.require(:comment).permit(:Text)
  end
end

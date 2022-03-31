class LikesController < ApplicationController
  before_action :current_user, only: [:create]

  def create
    @post = Post.find(params[:post_id])
    new_like = current_user.likes.new(
      users_id: current_user.id,
      post_id: @post.id
    )

    if new_like.save
      flash[:success] = 'Like saved successfully'
      redirect_to user_post_path(current_user.id, @post)
    else
      render :new
      flash.now[:error] = 'Like not saved'
    end
  end
end

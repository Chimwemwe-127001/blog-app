class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :current_user, only: [:create]

  def index
    @user = User.find(params[:user_id])
    # avoid N+1 query
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.users_id)
    @comments = @post.comments
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.users_id = current_user.id

    if @post.save
      flash[:success] = 'Post saved successfully'
      redirect_to user_path(current_user.id)
    else
      render :new
      flash.now[:error] = 'Post not saved'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = 'Post deleted successfully'
    redirect_to "/users/#{params[:id]}"
  end

  private

  def post_params
    params.require(:post).permit(:Title, :Text)
  end
end

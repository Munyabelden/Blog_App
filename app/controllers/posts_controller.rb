require 'cancancan'

class PostsController < ApplicationController
  def index
    @posts = Post.includes(:author).where(author_id: params[:user_id])
    @user = User.includes(:posts, :comments).find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to user_posts_path(current_user)
    else
      render :new
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if can? :destroy, @post
      @post.destroy
      redirect_to "/users/#{current_user.id}/posts", notice: 'Successfully deleted.'
    else
      redirect_to user_post_path(@post.author, @post), alert: 'Unauthorized action.'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end

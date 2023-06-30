class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @posts = Post.includes(:author).where(author_id: params[:user_id])
    @user = User.includes(:posts, :comments).find(params[:user_id])
    render json: { posts: @posts }
  end

  def show
    @post = Post.find(params[:id])
    render json: { post: @post }
  end
end

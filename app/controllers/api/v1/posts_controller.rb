class Api::V1::PostsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @posts = Post.includes(:author).where(author_id: params[:user_id])
    @user = User.includes(:posts, :comments).find(params[:user_id])
    response do |format|
      format.json do
        render json: {
          post: @posts.as_json(include: { author: { only: %i[id name] } })
        }, status: :ok
      end
    end
  end

  def show
    @post = Post.find(params[:id])
    render json: { post: @post }, status: :ok
  end
end

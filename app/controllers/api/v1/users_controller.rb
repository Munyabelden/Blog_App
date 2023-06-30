class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate_user!

  def posts
    @user = User.find(params[:id])
    @posts = @user.posts
    render json: { posts: @posts }
  end
end

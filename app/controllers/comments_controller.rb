class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @post = Post.find(params[:post_id])
    @comment.post = @post
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(@post.author, @post)
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post

    if can? :destroy, @comment
      @comment.destroy
      redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully deleted.'
    else
      redirect_to user_posts_path(current_user), alert: 'You are not authorized to delete this comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

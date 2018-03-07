class CommentsController < ApplicationController
  before_action :find_ticket

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = 'You comment has been saved'
      redirect_to :back
    else
      flash[:alert] = 'Something went wrong'
      render root_path
    end
  end

  def destroy
    @comment = @ticket.comments.find(params[:id])

    @comment.destroy
    flash[:success] = 'Comment deleted'
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_ticket
    @ticket = Post.find(params[:ticket_id])
  end
end

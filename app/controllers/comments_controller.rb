class CommentsController < ApplicationController
  before_action :find_ticket, only: %i[create destroy]

  def create
    @comment = @ticket.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @ticket }
        format.js
      end
    else
      flash[:alert] = 'Something went wrong'
      render root_path
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.user_id == current_user.id
      @comment.delete
      respond_to do |format|
        format.html { redirect_to @ticket }
        format.js
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end

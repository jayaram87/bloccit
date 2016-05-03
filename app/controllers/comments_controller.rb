class CommentsController < ApplicationController
    before_action :require_sign_in
    before_action :authorize_user, only: [:destroy]
    
    def create
        @comment = Comment.new
        if @comment == Topic.comments(params[:id])
            topic_comment(@comment)
        elsif @comment == Post.comments(params[:id])
            post_comment(@comment)
        end
        
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        if @comment == Topic.comments.find(params[:id])
            delete_topic_comment(@comment)
        elsif @comment == Post.comments.find(params[:id])
            delete_post_comment(@comment)
        end
    end
    
    private
    def comment_params
        params.require(:comment).permit(:body)
    end
    
    def authorize_user
        comment = Comment.find(params[:id])
        unless current_user == comment.user || current_user.admin?
            flash[:alert] = "You don't permission to delete the comment"
            redirect_to [comment.post.topic,comment.post]
        end
    end

end

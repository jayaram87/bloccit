class CommentsController < ApplicationController
    before_action :require_sign_in
    before_action :authorize_user, only: [:destroy]
    
    def create
        @comment = Comment.new(comment_params)
        if params[:topic_id]
            # create comment for topic
            @topic = Topic.find(params[:topic_id])
            @comment.topic = @topic
            
            if comment.save
                flash[:notice] = "Topic Comment was saved"
                redirect_to @topic
            else
                flash[:alert] = "Comment was not saved"
                redirect_to @topic
            end
    
        else
            # create comment for post
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

class CommentsController < ApplicationController
    before_action :require_sign_in
    before_action :authorize_user, only: [:destroy]
    
    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        if params[:topic_id]
            # create comment for topic
            @topic = Topic.find(params[:topic_id])
            @comment.topic = @topic
            
            if @comment.save
                flash[:notice] = "Topic Comment was saved"
                redirect_to @topic
            else
                flash[:alert] = "Comment was not saved"
                redirect_to @topic
            end
    
        else
            # create comment for post
            @post = Post.find(params[:post_id])
            @comment.post = @post
                
            if @comment.save
                flash[:notice] = "Post Comment was saved"
                redirect_to [@post.topic, @post]
            else
                flash[:alert] = "Comment was not saved"
                redirect_to [@post.topic, @post]
            end
        end    
        
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        if params[:topic_id]
            @topic = Topic.find(params[:topic_id])
            
            if @comment.destroy
                flash[:notice] = "Topic Comment was deleted"
                redirect_to @topic
            else
                flash[:alert] = "Comment was not deleted"
                redirect_to @topic
            end
        else
            @post = Post.find(params[:post_id])
           
            if @comment.destroy
                flash[:notice] = "Post Comment was deleted"
                redirect_to [@post.topic, @post]
            else
                flash[:alert] = "Comment was not deleted"
                redirect_to [@post.topic, @post]
            end
            
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

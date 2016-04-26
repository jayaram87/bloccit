class PostsController < ApplicationController
  
  before_action :require_sign_in, except: :show
  
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    
    if current_user || current_user.admin? || current_user.moderator?
      if @post.save
        flash[:notice] = "Post was saved."
        redirect_to [@topic, @post]
      else
        flash.now[:alert] = "There was an error saving the post. Please try again."
        render :new
      end
    else
      redirect_to [@topic,@post]
    end  
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)
    @post.user = current_user
    
    if current_user || current_user.admin? || current_user.moderator?
      if @post.save
        flash[:notice] = "Post was updated."
        redirect_to [@post.topic, @post]
      else
        flash.now[:alert] = "There was an error saving the post. Please try again."
        render :edit
      end
    else
      redirect_to [@topic,@post]
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.user = current_user

    if current_user || current_user.admin?
      if @post.destroy
        flash[:notice] = "\"#{@post.title}\" was deleted successfully."
        redirect_to @post.topic
      else
        flash.now[:alert] = "There was an error deleting the post."
        render :show
      end
    else
      redirect_to [@topic,@post]
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :body)
  end
  
  def authorize_user
    post = Post.find(params[:id])
    
    unless current_user == post.user || current_user.admin?
      flash[:alert] = "You're either an admin or the owner of the post"
      redirect_to [post.topic, post]
    end
  end
  
end

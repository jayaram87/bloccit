class SponsorPostsController < ApplicationController
  def show
    @sponsor_post = SponsorPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsor_post = SponsorPost.new
  end
  
  def create
    @sponsor_post = SponsorPost.new
    @sponsor_post.title = params[:sponsor_post][:title]
    @sponsor_post.body = params[:sponsor_post][:body]
    @sponsor_post.price = params[:sponsor_post][:price]
    @topic = Topic.find(params[:topic_id])
    
    @sponsor_post.topic = @topic

    if @sponsor_post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @sponsor_post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def edit
    @sponsor_post = SponsorPost.find(params[:id])
  end
  
  def update
    @sponsor_post = SponsorPost.find(params[:id])
    @sponsor_post.title = params[:sponsor_post][:title]
    @sponsor_post.body = params[:sponsor_post][:body]
    @sponsor_post.price = params[:sponsor_post][:price]

    if @sponsor_post.save
      flash[:notice] = "Sponsor post was updated."
      redirect_to [@sponsor_post.topic, @sponsor_post]
    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

end

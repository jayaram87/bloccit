class TopicsController < ApplicationController
    
    before_action :require_sign_in, except: [:index, :show]
    before_action :authorize_user, except: [:index, :show]
    
    def index
        @topics = Topic.visible_to(current_user)
    end
    
    def show
        @topic = Topic.find(params[:id])
        
        unless @topic.public || current_user
            flash[:notice] = "You must sign in to view private topics"
            redirect_to new_session_path
        end
    end
    
    def new
        @topic = Topic.new
    end
    
    def create
        @topic = Topic.new(topic_params)
        
        if @topic.save
            @topic.labels = Label.update_labels(params[:topic][:labels])
            redirect_to @topic, notice: "Topic was created"
        else
            flash.now[:alert] = "Error creating the topic"
            render :new
        end
    
    end
    
    def edit
        @topic = Topic.find(params[:id])
    end
    
    def update
        @topic = Topic.find(params[:id])
        @topic.assign_attributes(topic_params)
        
        if @topic.save
            @topic.labels = Label.update_labels(params[:topic][:labels])
            flash[:notice] = "Topic was updated"
            redirect_to @topic
        else
            flash.now[:alert] = "Error updating the topic"
            render :edit
        end
    end
    
    def destroy
        @topic = Topic.find(params[:id])
        
        if @topic.destroy
            flash[:notice] = "\"#{@topic.name}\" was deleted"
            redirect_to topics_path
        else
            flash.now[:alert] = "There was an error when deleting"
            render :show
        end
    
    end
    
    private
    def topic_params
        params.require(:topic).permit(:name, :body, :public)
    end
    
    def authorize_user
        unless current_user.admin?
            flash[:alert] = "You must not be the admin"
            redirect_to topics_path
        end
    end
end

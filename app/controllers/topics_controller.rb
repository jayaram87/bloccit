class TopicsController < ApplicationController
    
    before_action :require_sign_in, except: [:index, :show]
    before_action :authorize_user , except: [:index, :show] do
        before_action :moderator_user, only: [:index, :show, :edit, :update]
    end
    
    def index
        @topics = Topic.all
    end
    
    def show
        @topic = Topic.find(params[:id])
    end
    
    def new
        @topic = Topic.new
    end
    
    def create
        @topic = Topic.new(topic_params)
        
        if @topic.save
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
            if current_user.moderator?
            end
            flash[:alert] = "You must not be an admin"
            redirect_to topics_path
        end
    end
    
    def moderator_user
        unless current_user.moderator?
            flash[:alert] = "You must not be a moderator"
            redirect_to topics_path
        end
    end
    
end

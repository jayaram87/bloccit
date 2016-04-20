class TopicsController < ApplicationController
    
    before_action :require_sign_in, except: [:index, :show]
    
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
        if current_user.admin? || current_user == @topic.user
        
            if @topic.save
                redirect_to @topic, notice: "Topic was created"
            else
                flash.now[:alert] = "Error creating the topic"
                render :new
            end
        else
            render :show
        end

    end
            
    def edit
        @topic = Topic.find(params[:id])
    end
    
    def update
        @topic = Topic.find(params[:id])
       
        if current_user.moderator? || current_user == @topic.user || current_user.admin?
            @topic.assign_attributes(topic_params)
        
            if @topic.save
                flash[:notice] = "Topic was updated"
                redirect_to @topic
            else
                flash.now[:alert] = "Error updating the topic"
                render :edit
            end
        else
            render :show
        end

    end
    
    def destroy
        @topic = Topic.find(params[:id])
        
        if current_user.admin? || current_user == @topic.user
            if @topic.destroy
                flash[:notice] = "\"#{@topic.name}\" was deleted"
                redirect_to topics_path
            else
                flash.now[:alert] = "There was an error when deleting"
                render :show
            end
        else
            render :show
        end
    
    end
    
    private
    def topic_params
        params.require(:topic).permit(:name, :body, :public)
    end
    
end

class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]
    
    if @question.save
      flash[:notice] = "Question was saved"
      redirect_to @question
    else
      flash.now[:alert] = "There is an error"
      render :new
    end
    
  end  

  def edit
    @question = Question.find(params[:id])
  end
  
  def update
    @question = Question.find(params[:id])
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]
    
    if @question.save
      flash[:notice] = "The question has been updated"
      redirect_to @question
    else
      flash.now[:alert] = "There was an error when savings"
      render :edit
    end
    
  end
  
  def destroy
    @question = Question.find(params[:id])
    
    if @question.destroy
       flash[:notice] = "\"#{@question.title}\" was deleted successfully."
       redirect_to questions_path
    else
       flash.now[:alert] = "There was an error deleting the post."
       render :show
    end
    
  end
    
end

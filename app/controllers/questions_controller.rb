class QuestionsController < AdminController
  skip_before_filter :authenticate_user!, :only => [:random]
  skip_before_filter :admin_required, :only => [:random]

  def new
    @question = Question.new
  end
  
  def create
    @question = Question.new params[:question]
    if @question.save
      flash[:notice] = "Quiz question saved!"
      redirect_to :action => "index"
    else
      render :action => "new"
    end

  end
  
  def index
    @questions = Question.all
  end
  
  def edit
    @question = Question.find params[:id]
  end
  
  def update
    @question = Question.find params[:id]
    if @question.update_attributes params[:question]
      flash[:notice] = "Quiz question saved!"
      redirect_to :action => "index"
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @question = Question.find params[:id]
    if @question.destroy
      flash[:notice] = "Quiz question deleted!"
    end
    redirect_to :action => "index"
  end
  
  def random
    @questions = Question.all
    @questions = [@questions[rand(@questions.length)]]
  end
end

class Admin::HomophoneSetsController < AdminController
  layout "admin"
  before_filter :load_homophone_sets

  def index
    @homophone_set = HomophoneSet.new
  end

  def new
    @homophone_set = HomophoneSet.new
  end
  
  def create
    homophones = params[:homophone_set].delete(:homophones).values
    @homophone_set = HomophoneSet.new params[:homophone_set]
    homophones.each do |attrs|
      @homophone_set.homophones.build(attrs) if attrs[:name].present? || attrs[:definition].present?
    end
    if @homophone_set.save
      redirect_to admin_index_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @homophone_set = HomophoneSet.find params[:id]
  end
  
  def update
    @homophone_set = HomophoneSet.find params[:id]
    homophone_params = params[:homophone_set].delete(:homophones).values
    
    begin
      HomophoneSet.transaction do
        @homophone_set.homophones.destroy_all
        homophones = homophone_params.each do |attrs|
          @homophone_set.homophones.build(attrs) if attrs[:name].present? || attrs[:definition].present?
        end
        @homophone_set.save!
      end
      redirect_to admin_index_path
    rescue ActiveRecord::RecordInvalid
      render :action => 'edit'
    end
  end

  private
  def load_homophone_sets
    @homophone_sets = HomophoneSet.all(:include => :homophones).sort
  end
end

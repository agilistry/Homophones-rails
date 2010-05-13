class Admin::HomophoneSetsController < AdminController
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
      redirect_to admin_path
    else
      render :action => 'new'
    end
  end
end

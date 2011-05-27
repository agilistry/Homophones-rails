class HomophoneSetsController < ApplicationController
  before_filter :admin_required

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
      redirect_to root_path
    rescue ActiveRecord::RecordInvalid
      render :action => 'edit'
    end
  end
end

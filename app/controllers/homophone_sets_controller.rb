class HomophoneSetsController < ApplicationController
  before_filter :admin_required

  def new
    @homophone_set = HomophoneSet.new
    @homophone_set.fill_empty_homophones(4)
    render :partial => 'edit', :locals => {:homophone_set => @homophone_set}
  end

  def edit
    @homophone_set = HomophoneSet.find params[:id]
    render :partial => 'edit', :locals => {:homophone_set => @homophone_set}
  end

  def create
    homophones = params[:homophone_set].delete(:homophones).values
    @homophone_set = HomophoneSet.new params[:homophone_set]
    homophones.each do |attrs|
      @homophone_set.homophones.build(attrs) if attrs[:name].present? || attrs[:definition].present?
    end
    @homophone_set.save

    render :partial => "display", :locals => { :homophone_set => @homophone_set }
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
      render :partial => "display", :locals => { :homophone_set => @homophone_set }
    rescue ActiveRecord::RecordInvalid
    end
  end

end

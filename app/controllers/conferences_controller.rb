class ConferencesController < ApplicationController
  before_action :admin_access

  def index
    @conferences = Conference.all
  end

  def new
    @conference = Conference.new
  end

  def create
    @conference = Conference.new(conference_params)
    if @conference.save
      flash[:success] = "Conference has been added to the list."
      redirect_to conferences_path
    else
      render 'new'
    end
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def update
  @conference = Conference.find(params[:id])
  if @conference.update(conference_params)
    redirect_to conferences_path
  else
    render 'edit'
  end
end

  def show
    @conference = Conference.find(params[:id])
  end

  def destroy
    Conference.find(params[:id]).destroy
    flash[:success] = "Conference deleted"
    redirect_to conferences_path
  end

  private 

  def conference_params
    params.require(:conference).permit(:name, :start_date, :end_date, :fee)
  end 
end

class PapersController < ApplicationController

  def index
		@papers = current_user.papers
		@user = current_user
	end

	def new
    @user = current_user
		@paper = current_user.papers.build
	end

	def create
    @user = current_user
		@paper = current_user.papers.new(paper_params)
    if @paper.save
      flash[:success] = "The new paper has been saved to your account"
      redirect_to user_papers_path(@user)
    else
      render 'papers/new'
    end
	end

	def edit
    @paper = current_user.papers.find(params[:id])
    @user = current_user
  end

  def update
    @paper = current_user.papers.find(params[:id])
    if @paper.update(paper_params)
      flash[:success] = "Your paper has been successfully updated"
      redirect_to user_papers_path
    else
      render 'edit'
    end
  end

  def destroy
    current_user.papers.find(params[:id]).destroy
    flash[:success] = "Paper deleted"
    redirect_to user_papers_path
  end

	private
  def paper_params
    params.require(:paper).permit(:title, :authors, :attachment, :remove_attachment)
  end

end

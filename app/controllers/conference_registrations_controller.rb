class ConferenceRegistrationsController < ApplicationController

	def index
		@user = current_user
		@user_registrations = current_user.conference_registrations
	end

	def select_conference
		@conferences = Conference.all
	end

	def new
		@user = current_user
		@papers = current_user.papers
    @conference = Conference.find(params[:conference_id])
    @conf_reg = ConferenceRegistration.new
	end 

	def create
		@conf_reg = ConferenceRegistration.new(registration_params)
		@conf_reg.paper_id = params[:paper_id]
    session[:tmp_conf_reg] = @conf_reg
    redirect_to action: :registration_summary
	end

	def edit

	end

	def edit

	end

	def destroy
	end

	def registration_summary
		@conf_reg = session[:tmp_conf_reg]
		@paper = Paper.find(@conf_reg["paper_id"])
		@conference = Conference.find(@conf_reg["conference_id"])
		@cards = current_user.credit_cards
	end

	def final
		@conf_reg = ConferenceRegistration.new(session[:tmp_conf_reg])
		@receipt = Receipt.new
		@receipt.credit_card_id = params[:credit_card_id]
		@receipt.total = params[:total]
		@conf_reg.save
		@receipt.conference_registration_id = @conf_reg.id
		if @receipt.save
			flash[:success] = "Thank you for registering!"
			UserMailer.receipt(current_user, @receipt, @conf_reg).deliver_now
			redirect_to receipt_path(@receipt.id)
		else
      flash[:danger] = "Something went wrong in saving your registration!"
			render 'registration_summary'
		end
	end

	private
  def registration_params
    params.require(:conference_registration).permit(:name, :email, :diet, :paper_id, :user_id, :conference_id, :total)
  end
end

class ConferenceRegistrationsController < ApplicationController
  
  @@discount = 0

	def index
		@user = current_user
		@user_registrations = current_user.conference_registrations
	end

	def select_conference
		@conferences = Conference.all
	end

	def select_events
		@conference = Conference.find(params[:conference_id])
		@events = @conference.events
	end

	def new
		@user = current_user
		@papers = current_user.papers
    @conference = Conference.find(params[:conference_id])
    @conf_reg = ConferenceRegistration.new
    session[:events] ||= []
    session[:events] = params[:events]
    @events = session[:events]
	end 

	def create
		@conf_reg = ConferenceRegistration.new(registration_params)
		@conf_reg.paper_id = params[:paper_id]
    session[:tmp_conf_reg] = @conf_reg
    redirect_to action: :registration_summary
	end

	def get_discount
		if params[:discount]
			@@discount = params[:discount]
		end
		redirect_to action: :registration_summary
	end

	def registration_summary
		@coupon = Coupon.new
		@events = session[:events]
		@event_fees = 0
		@events.each do |event|
			event = Event.find_by(id: event.to_i)
			@event_fees = @event_fees + event.fee
		end
		@conf_reg = session[:tmp_conf_reg]
		@paper = Paper.find(@conf_reg["paper_id"])
		@conference = Conference.find(@conf_reg["conference_id"])
		@total = @conference.fee + @conference.paper_fee + @event_fees
		@cards = current_user.credit_cards
	end

	def final
		@conference = Conference.find(session[:tmp_conf_reg]["conference_id"])
    @discount = @@discount.to_d
	  @fee = @conference.fee
		@paper_fee = @conference.paper_fee
		@event_fees = 0

		@events = session[:events]
		@events.each do |event|
			event = Event.find_by(id: event.to_i)
			@event_fees = @event_fees + event.fee
			@event_reg = EventRegistration.new({:user_id => current_user.id, :event_id => event.id})
      @event_reg.save			
		end
	  
    @total = @fee + @paper_fee + @event_fees
    @total = @total- (@discount* @total)

		@conf_reg = ConferenceRegistration.new(session[:tmp_conf_reg])

		@receipt = Receipt.new
		@receipt.credit_card_id = params[:credit_card_id]
		@receipt.total = @total

		@conf_reg.save

		@receipt.conference_registration_id = @conf_reg.id

		if @receipt.save
			flash[:success] = "Registration complete. Please print a copy of this receipt for your records."
			UserMailer.receipt(current_user, @receipt, @conf_reg).deliver_now
			@@discount = 0
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

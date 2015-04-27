class ConferenceRegistrationsController < ApplicationController
  skip_before_filter :verify_authenticity_token
	
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
		if params[:events]
			session[:events] ||= []
			session[:events] = params[:events]
			@events = session[:events]
		else
			session[:events] = 0 
		end
	end 

	def create
		@conf_reg = ConferenceRegistration.new(registration_params)
		if params[:paper_id]
			@conf_reg.paper_id = params[:paper_id]
		else
			@conf_reg.paper_id = nil
		end 
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
		@user = current_user
		# Retrieve selected conference registration details.
	  @conf_reg = session[:tmp_conf_reg]
		@conference = Conference.find_by(id: @conf_reg["conference_id"])
		
		# Initialize new coupon.
		@coupon = Coupon.new
    
    # Initialize fees.
    @fee = @conference.fee
		@event_fees = 0
		@paper_fee = 0
   

    # If event was selected...
		@events = session[:events]
		if @events != 0
			@events.each do |event|
				event = Event.find_by(id: event.to_i)
				@event_fees = @event_fees + event.fee
			end
		end

		# If paper was selected...
		@paper_id = @conf_reg["paper_id"]
		if @paper_id != nil
			@paper = Paper.find_by(id: @paper_id)
		  @paper_fee = @conference.paper_fee
		end
		
		@total = @fee + @paper_fee + @event_fees

		@cards = current_user.credit_cards
	end

	def final
		@conference = Conference.find_by(id: session[:tmp_conf_reg]["conference_id"])
		
    # Initialize fees and discounts.
    @discount = @@discount.to_d
		@fee = @conference.fee
		@paper_fee = 0
		@event_fees = 0
		
    # If events where selected...
		@events = session[:events]
		@event_regs = Array.new
		if @events != 0
		  @events.each do |event|
			  event = Event.find_by(id: event.to_i)
			  @event_fees = @event_fees + event.fee
			  @event_reg = EventRegistration.new({:user_id => current_user.id, :event_id => event.id})
			  @event_reg.save
			  @event_regs << @event_reg	
		  end
		end
    
    # Save conference registration.
		@conf_reg = ConferenceRegistration.new(session[:tmp_conf_reg])
		@conf_reg.save

    # If a paper was selected...
    @paper_id = @conf_reg.paper_id
    if @paper_id != nil
    	@paper_fee = @conference.paper_fee
    end
		
		# Calculate subtotal.
		@sub_total = @fee + @paper_fee + @event_fees
		
    # Calculate discounted total, if any.
		@total = @sub_total - (@discount * @sub_total)

		# Create a new receipt.
		@receipt = Receipt.new
		@receipt.credit_card_id = params[:credit_card_id]
		@receipt.total = @total
		@receipt.conference_registration_id = @conf_reg.id

		if @receipt.save
			flash[:success] = "Registration complete. Please print a copy of this receipt for your records."
			UserMailer.receipt(current_user, @receipt, @conf_reg, @event_regs).deliver_now
			@@discount = 0
			redirect_to receipt_path(@receipt.id)
		else
			flash[:danger] = "Duplicate registration: It looks like you've already registered for this conference."
			render 'registration_summary'
		end
	end

	private
	def registration_params
		params.require(:conference_registration).permit(:name, :email, :diet, :paper_id, :user_id, :conference_id, :total)
	end
end

class ReceiptsController < ApplicationController

  def show
    @receipt = Receipt.find(params[:id])
    @total = @receipt.total
    @conf_reg = ConferenceRegistration.find_by(id: @receipt.conference_registration_id)
  	@conference = Conference.find_by(id: @conf_reg.conference_id)
    @fee = @conference.fee
    @paper = Paper.find_by(id: @conf_reg.paper_id)
    if @paper
       @paper_fee = @conference.paper_fee
    end
  	@user = current_user
  	@card = CreditCard.find_by(id: @receipt.credit_card_id)
  	@events = session[:events]
    if @events != 0
      @events = Array.new
		  session[:events].each do |event|
      @events << Event.find_by(id: event.to_i)
		  end
      @event_fees = 0
      @events.each do |event|
        @event_fees = @event_fees + event.fee
      end
    end
  end
end

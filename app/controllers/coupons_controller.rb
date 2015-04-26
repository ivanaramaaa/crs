class CouponsController < ApplicationController

	def check_coupon_code

		# Retrieve selected conference registration details.
	  @conf_reg = session[:tmp_conf_reg]
		@conference = Conference.find(@conf_reg["conference_id"])
		
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
		@paper = @conf_reg["paper_id"]
		if @paper != nil
			@paper = Paper.find_by(id: @paper)
		  @paper_fee = @conference.paper_fee
		end

		@discount = nil
		@discount_name = ""
		@coupons = @conference.coupons
		@coupons.each do |coupon|
			if coupon.code == params[:coupon]["code"]
				@discount = coupon.discount
				@discount_name = coupon.name
			end
		end

    # Calculate totals. 
		@total = @fee + @paper_fee + @event_fees
		
		if @discount != nil
		@total_due = @total - (@discount * @total)
    end

		respond_to do |format|
			if @discount != nil
				format.js
			else
				format.js {render action: "fail"}
			end
		end
	end
end


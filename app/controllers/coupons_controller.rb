class CouponsController < ApplicationController

	def check_coupon_code
		@conference = Conference.find(session[:tmp_conf_reg]["conference_id"])
		@events = session[:events]
		@event_fees = 0
		@events.each do |event|
			event = Event.find_by(id: event.to_i)
			@event_fees = @event_fees + event.fee
		end
		@discount = nil
		@coupons = @conference.coupons
		@coupons.each do |coupon|
			if coupon.code == params[:coupon]["code"]
				@discount = coupon.discount
			end
		end
		respond_to do |format|
			if @discount
				format.js
			else
				format.js {render action: "fail"}
			end
		end
	end
end


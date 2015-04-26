class CreditCardsController < ApplicationController
  
  def index
    @credit_cards = current_user.credit_cards
    @user = current_user
  end

  def new
    @credit_card = current_user.credit_cards.build
    @user = current_user
  end

  def create
    @user = current_user
    @credit_card = current_user.credit_cards.new(card_params)
    if @credit_card.save
      flash[:success] = "The new credit card has been saved to your account"
      redirect_to user_credit_cards_path(@user)
    else
      render 'credit_cards/new'
    end
  end

  def edit
    @credit_card= current_user.credit_cards.find(params[:id])
  end

  def update
    @credit_card = current_user.credit_cards.find(params[:id])
    if @credit_card.update(card_params)
      flash[:success] = "Your credit card has been successfully updated"
      redirect_to user_credit_cards_path
    else
      render 'edit'
    end
  end

  def destroy
    current_user.credit_cards.find(params[:id]).destroy
    flash[:success] = "Credit card deleted"
    redirect_to user_credit_cards_path
  end

  def last_digits(number)    
    number.length <= 4 ? number : number.slice(-4..-1) 
  end

   def mask(number)
     "XXXX-XXXX-XXXX-#{last_digits(number)}"
   end

  private
  def card_params
    params.require(:credit_card).permit(:name, :number, :month, :year, :cvv, :cc_type)
  end
end


class ChargesController < ApplicationController

before_filter :login_required, only: [:new, :create, :index, :destroy]

def new
end

def create
	Stripe.api_key = "sk_live_WHIBjydKTdcM5JjOYor60dQT"
  # Amount in cents
  @amount = params[:amount]
   
  customer = Stripe::Customer.create(
    :email => "#{current_user.email}",
    :card  => params[:stripeToken]
  ) 

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount,
    :description => 'Rails Stripe customer',
    :currency    => 'usd'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end

def index
end

private
  def login_required
    unless current_user
      flash[:error] = 'You must be logged in to view this page.'
      redirect_to new_user_session_path
    end
  end
end
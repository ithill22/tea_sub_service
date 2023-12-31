class Api::V0::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:customer_id])
    subscriptions = customer.subscriptions
    render json: SubscriptionSerializer.new(subscriptions), status: :ok
  end

  def create
    subscription = Subscription.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def destroy
    customer = Customer.find(params[:customer_id])
    subscription = customer.subscriptions.find(params[:id])
    subscription.update(status: 'cancelled')
    render json: SubscriptionSerializer.new(subscription), status: :ok
  end

  private

  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end
class Api::V0::SubscriptionsController < ApplicationController
  def create
    subscription = Subscription.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: :created
  end

  def destroy
    subscription = Subscription.find(params[:id])
    subscription.update(status: 'cancelled')
    render json: SubscriptionSerializer.new(subscription), status: :ok
  end

  private

  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end
end
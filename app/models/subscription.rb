class Subscription < ApplicationRecord
  validates_presence_of :title, :price, :status, :frequency, :customer_id, :tea_id

  belongs_to :customer
  belongs_to :tea

  enum status: [:active, :cancelled]
  enum frequency: [:weekly, :biweekly, :monthly]
end

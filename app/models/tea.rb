class Tea < ApplicationRecord
  validates_presence_of :title, :description, :temperature, :brew_time
  validates_numericality_of :temperature, :brew_time

  has_many :subscriptions
  has_many :customers, through: :subscriptions
end

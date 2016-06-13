class Order < ActiveRecord::Base
  belongs_to :table, inverse_of: :orders
  has_many :order_items
  has_many :items, through: :order_items

  def total_amount
    items.inject(0) { |sum, sum| }
  end
end

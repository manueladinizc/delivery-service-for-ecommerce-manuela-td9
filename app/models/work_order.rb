class WorkOrder < ApplicationRecord
    enum work_order_status: { pending: 0,  progress: 1 }

    before_validation :generate_delivery_code, on: :create

    has_one :open_work_order

    validates :pickup_address, :pickup_city, :pickup_state, :product_code, :height, :width, :depth, :weight, :delivery_address, :customer_name , :delivery_city, :delivery_state, :distance, presence: true
    
    private
  def generate_delivery_code
    self.delivery_code = SecureRandom.alphanumeric(15).upcase
  end
end

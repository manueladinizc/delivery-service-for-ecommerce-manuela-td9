class WorkOrder < ApplicationRecord
    enum work_order_status: { pending: 0,  progress: 1 }

    before_validation :generate_delivery_code, on: :create

    has_one :open_work_order
    
    private
  def generate_delivery_code
    self.delivery_code = SecureRandom.alphanumeric(15).upcase
  end
end

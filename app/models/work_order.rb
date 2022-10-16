class WorkOrder < ApplicationRecord
    enum work_order_status: { pending: 0,  progress: 1, closed_in: 2, closed_out: 3 }

    has_one :open_work_order
    has_one :close_work_order
    
    before_validation :generate_delivery_code, on: :create

    validates :pickup_address, :pickup_city, :pickup_state, :product_code, :height, :width, :depth, :weight, :delivery_address, :customer_name , :delivery_city, :delivery_state, :distance, presence: true
    validates :product_code, format: {with: /\A[a-zA-Z0-9]{8}\z/, message: "deve conter 8 caracteres entre letas e números"}
    validate :min_weight, :min_width, :min_height, :min_depth, :min_distance

    def min_weight
      if (self.weight.present? && self.weight <= 0)
        self.errors.add(:weight, "deve ser maior que 0")
         end
    end
  
    def min_width
      if (self.width.present? && self.width <= 0)
         self.errors.add(:width, "deve ser maior que 0")
         end
    end
  
    def min_height
      if (self.height.present? && self.height <= 0)
        self.errors.add(:height, "deve ser maior que 0")
      end
    end
  
    def min_depth
      if (self.depth.present? && self.depth <= 0)
        self.errors.add(:depth, "deve ser maior que 0")
         end
    end

    def min_distance
      if (self.distance.present? && self.depth <= 0)
        self.errors.add(:distance, "deve ser maior que 0")
         end
    end
    
    private
  def generate_delivery_code
    self.delivery_code = SecureRandom.alphanumeric(15).upcase
  end
end

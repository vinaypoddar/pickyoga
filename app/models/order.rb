class Order < ActiveRecord::Base
    belongs_to :user
    has_many :order_items
    before_create :set_order_status
    before_save :update_amount
    
    scope :complete, ->{ where(status: "complete") }
    
    def amount
        order_items.collect { |oi| oi.valid? ? (oi.quantity * oi.unit_price) : 0 }.sum
    end
    
    private
      def set_order_status
        self[:status] = "in progress"
      end
    
      def update_amount
        self[:amount] = amount
      end
end

class Plan < ActiveRecord::Base
    validates :title, presence: true
    validates :price, presence: true
end

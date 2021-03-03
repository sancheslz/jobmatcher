class Offer < ApplicationRecord
  validates :comment, :presence => true
  validates :salary, :start_at, :presence => true, :on => :accept
  
  
  belongs_to :submission
  belongs_to :profile
end

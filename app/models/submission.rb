class Submission < ApplicationRecord
  validates :wage_claim, :presentation, presence: true
  
  belongs_to :opportunity
  belongs_to :profile
end

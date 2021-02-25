class Submission < ApplicationRecord
  validates :wage_claim, :presentation, presence: true
  enum status: {
    applied: 0,
    accepted: 10,
    denied: 20,
    removed: 90,
  }
  
  belongs_to :opportunity
  belongs_to :profile

  def get_offer!
    Offer.find_by(submission: self)
  end

end

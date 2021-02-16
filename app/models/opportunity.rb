class Opportunity < ApplicationRecord

    before_save :add_date_if_empty

    validates :title, :description, :requirement, presence: true
    enum remote: { no: false, yes: true }
    enum level: { entry: 10, mid: 20, senior: 30 }
    belongs_to :company

    private 
    def add_date_if_empty
        if self.expiration_date.nil?
            self.expiration_date = 30.days.from_now
        end
    end
end

class Opportunity < ApplicationRecord
    validates :title, :description, :requirement, presence: true
    enum remote: { no: false, yes: true }
    enum level: { entry: 10, mid: 20, senior: 30 }
end

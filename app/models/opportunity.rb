class Opportunity < ApplicationRecord

    has_many :technology_opportunity
    has_many :technologies, through: :technology_opportunity

    has_many :submissions
    has_many :candidates, through: :submissions

    before_save :add_date_if_empty

    validates :title, :description, :requirement, presence: true
    enum remote: { no: false, yes: true }
    enum level: { entry: 10, mid: 20, senior: 30 }
    belongs_to :company

    def change_visibility!
        self.is_visible = !self.is_visible
    end

    def applied?(current_user)
        !!Submission.find_by(
            opportunity: self,
            profile: current_user.profile
        )
    end

    def get_submission(current_user)
        Submission.find_by(
            opportunity: self,
            profile: current_user.profile
        )
    end

    def get_status(current_user)
        Submission.find_by(
            opportunity: self,
            profile: current_user.profile
        )
    end

    def count_valid 
        Submission.where(
            'opportunity_id = ? AND status <> ?',
            self,
            90 # Submission => :removed = 90
        ).count
    end

    private 
    def add_date_if_empty
        if self.expiration_date.nil?
            self.expiration_date = 30.days.from_now
        end
    end
end

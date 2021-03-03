class Company < ApplicationRecord
    validates :name, :cnpj, :website, :presence => true
    validates :cnpj, :uniqueness => true  
    has_many :company_profiles
    has_many :profiles, :through => :company_profiles
    has_one_attached :logo

    def change_state! 
        self.is_active = !self.is_active
    end

    def active?
        self.is_active
    end

    def is_mine?(current_user)
        CompanyProfile.find_by(
            :profile => current_user.profile,
            :company => self
        )
    end

    def active_opportunities
        Opportunity.where(
            'is_visible == ? AND company_id == ? AND expiration_date > ?',
            true,
            self,
            0.days.from_now
        ).count
    end
end

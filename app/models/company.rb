class Company < ApplicationRecord
    validates :name, :cnpj, :website, presence: true
    validates :cnpj, uniqueness: true  
    has_many :company_profiles
    has_many :profiles, through: :company_profiles
    has_one_attached :logo

    def change_state! 
        self.is_active = !self.is_active
    end

    def active?
        self.is_active
    end
end

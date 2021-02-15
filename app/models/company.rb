class Company < ApplicationRecord
    validates :name, :cnpj, :website, presence: true
    validates :cnpj, uniqueness: true  

    def change_state! 
        self.is_active = !self.is_active
    end

    def active?
        self.is_active
    end
end

class Profile < ApplicationRecord
    validates :name, :cpf, presence: true
    validates :cpf, uniqueness: true
    
    def active?
        self.is_active
    end
end

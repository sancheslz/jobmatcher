class Profile < ApplicationRecord
    validates :name, :cpf, presence: true
    validates :cpf, uniqueness: true
    belongs_to :user
    
    def active?
        self.is_active
    end
end

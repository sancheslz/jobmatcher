class Company < ApplicationRecord
    validates :name, :cnpj, :website, presence: true
    validates :cnpj, uniqueness: true    
end

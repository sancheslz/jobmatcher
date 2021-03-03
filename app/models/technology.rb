class Technology < ApplicationRecord
    validates :name, :presence => true
    validates :name, :uniqueness => { :case_sensitive => false }
    has_many :technology_opportunity
    has_many :opportunities, :through => :technology_opportunity

end

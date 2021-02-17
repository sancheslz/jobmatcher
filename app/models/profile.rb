class Profile < ApplicationRecord
    validates :name, :cpf, presence: true
    validates :cpf, uniqueness: true
    belongs_to :user
    has_many :company_profiles
    has_many :company, through: :company_profiles
    
    enum role: { regular: 10, business: 20, admin: 30 }
    
    def active?
        self.is_active
    end

    def is_regular?
        self.role == 'regular'
    end

    def set_role!(current_user)
        regular_domain = [
            '@gmail',   '@hotmail',     '@aol',         '@yahoo',
            '@msn',     '@mail',        '@zoho',        '@protonmail',
            '@icloud',  '@gmx',         '@thunderbird', '@yandex',
        ]

        domain = current_user.email.scan(/\@\w+/)[0]
        if regular_domain.include?(domain) 
            self.role = 'regular'
        elsif User.where('email like ?', "%#{domain}%").count == 1
            self.role = 'admin'
        else
            self.role = 'business'
        end
    end
end
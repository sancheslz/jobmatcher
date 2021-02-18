require 'rails_helper'

feature('New user has a role according his email') do

    scenario('general users are "regular"') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )
        
        # Act
        login_as user
        visit root_path
        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'Felismino da Conceição'
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '175.113.263-01'
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(current_path).to eq(root_path)
        expect(Profile.last.role).to eq('regular')

    end
    

    scenario('first business users are "admin"') do
        # Arrange
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )
        
        # Act
        login_as user
        visit root_path
        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'Graciliana Novaes'
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '388.586.242-26'
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(current_path).to eq(new_company_path)
        expect(Profile.last.role).to eq('admin')
    end


    scenario('other business users are "business"') do
        # Arrange
        first_user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )
        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: first_user
        )

        user = User.create!(
            email: 'miria.dasneves@cdev.com',
            password: 'smallwolf333'
        )
        
        # Act
        login_as user
        visit root_path
        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'Miriã das Neves'
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '788.163.279-21'
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(current_path).to eq(root_path)
        expect(Profile.last.role).to eq('business')
    end
    
end
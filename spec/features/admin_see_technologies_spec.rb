require 'rails_helper'

feature('Admin see technologies') do

    scenario('any records') do
        # Arrange 
        user = User.create!(
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
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
        end

        # Assert
        expect(page).to have_content(I18n.t('views.technologies.empty'))
    end

    scenario('see records') do
        # Arrange
        # Arrange 
        user = User.create!(
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
            user: user
        )

        technology = Technology.create!(
            name: 'Ruby'
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.technologies.title')
        end

        # Assert
        expect(page).to have_content(I18n.t('views.technologies.title'))
        expect(page).to have_content(technology.name)
    end

end
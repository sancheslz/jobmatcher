require 'rails_helper'

feature('User edit profile') do

    scenario('see the button on navbar') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
        end
        
        # Assert
        expect(page).to have_link(I18n.t('views.profiles.edit_submit')) 
    end

    scenario('some fields are required') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.profiles.edit_submit')
        end
        
        within('form') do
            fill_in I18n.t('activerecord.attributes.profile.name'), with: ''
            fill_in I18n.t('activerecord.attributes.profile.cpf'), with: ''
            click_on I18n.t('views.profiles.edit_submit')
        end

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 2) 
    end

    scenario('cpf must be unique') do
        # Arrange
        other_user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )
        other_profile = Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: other_user
        )

        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.profiles.edit_submit')
        end
        
        within('form') do
            fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '388.586.242-26'
            click_on I18n.t('views.profiles.edit_submit')
        end

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.taken'), count: 1)
    end

    scenario('with success') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.profiles.edit_submit')
        end
        
        within('form') do
            fill_in I18n.t('activerecord.attributes.profile.number'), with: '7971B'
            click_on I18n.t('views.profiles.edit_submit')
        end

        # Assert
        expect(current_path).to eq(profile_path(profile))
    end

end
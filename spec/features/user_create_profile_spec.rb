require 'rails_helper'

feature('User create a profile') do

    scenario('see page\'s title') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'graciliana.novaes@cdev.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: 'brownbird755'
            fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'brownbird755'
            click_on I18n.t('views.home.sign_up')
        end

        # Assert
        expect(page).to have_content(I18n.t('views.profiles.new_title'))
    end

    scenario('see the fields') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'graciliana.novaes@cdev.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: 'brownbird755'
            fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'brownbird755'
            click_on I18n.t('views.home.sign_up')
        end

        # Assert
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.name')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.cpf')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.bio')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.address')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.number')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.complement')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.neighborhood')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.city')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.state')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.postal_code')) 
        expect(page).to have_content(I18n.t('activerecord.attributes.profile.photo')) 
    end

    scenario('some are required') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'graciliana.novaes@cdev.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: 'brownbird755'
            fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'brownbird755'
            click_on I18n.t('views.home.sign_up')
        end

        fill_in I18n.t('activerecord.attributes.profile.name'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: ''
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 2) 
    end

    scenario('cpf must be unique') do
        # Arrange
        registered_user = User.create!(
            email: 'miria.dasneves@cdev.com',
            password: 'smallwolf333'
        )

        Profile.create!(
            name: 'Miriã das Neves',
            cpf: '788.163.279-21',
            address: 'Rua Tiradentes',
            number: '7654',
            complement: 'Fundos', 
            city: 'Toledo',
            state: 'Maranhão', 
            postal_code: '27244',
            role: 'business',
            user: registered_user
        )

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'graciliana.novaes@cdev.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: 'brownbird755'
            fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'brownbird755'
            click_on I18n.t('views.home.sign_up')
        end

        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'Graciliana Novaes'
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '788.163.279-21'
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.taken'), count: 1)
    end

    scenario('create with success') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'graciliana.novaes@cdev.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: 'brownbird755'
            fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: 'brownbird755'
            click_on I18n.t('views.home.sign_up')
        end
        
        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'Graciliana Novaes'
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '388.586.242-26'
        fill_in I18n.t('activerecord.attributes.profile.bio'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.address'), with: 'Rua Quatro'
        fill_in I18n.t('activerecord.attributes.profile.number'), with: '8229'
        fill_in I18n.t('activerecord.attributes.profile.complement'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.neighborhood'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.city'), with: 'Resende'
        fill_in I18n.t('activerecord.attributes.profile.state'), with: 'Roraima'
        fill_in I18n.t('activerecord.attributes.profile.postal_code'), with: '75674'
        attach_file I18n.t('activerecord.attributes.profile.photo'), Rails.root.join('spec', 'support', 'graciliana_novaes.jpg')
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(current_path).not_to eq(new_user_registration_path)
    end

end
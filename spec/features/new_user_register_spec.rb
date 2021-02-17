require 'rails_helper'

feature('New user can register') do

    scenario('have link to') do
        # Arrange

        # Act
        visit root_path

        # Assert 
        within('nav') do
            expect(page).to have_link(I18n.t('views.home.sign_up')) 
        end
    end

    scenario('see the form') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end

        # Assert 
        expect(current_path).to eq(new_user_registration_path)
    end

    scenario('fields are required') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            click_on I18n.t('views.home.sign_up')
        end

        # Assert 
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 2)
    end

    scenario('password must have more than 6 digits') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'user@gmail.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: '123'
            click_on I18n.t('views.home.sign_up')
        end

        # Assert 
        expect(page).to have_content(I18n.t('errors.messages.too_short.other', count: 6))
    end

    scenario('password and its confirmation must be equal') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'user@gmail.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: '123456'
            click_on I18n.t('views.home.sign_up')
        end

        # Assert 
        expect(page).to have_content(I18n.t('errors.messages.confirmation', attribute: I18n.t('activerecord.attributes.user.password')))
    end

    scenario('email must be unique') do
        # Arrange
        User.create!(
            email: 'user@gmail.com',
            password: '123456'
        )

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'user@gmail.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: '654321'
            click_on I18n.t('views.home.sign_up')
        end

        # Assert 
        expect(page).to have_content(I18n.t('errors.messages.taken'))
    end

    scenario('create with success') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_up')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'user@gmail.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: '654321'
            fill_in I18n.t('activerecord.attributes.user.password_confirmation'), with: '654321'
            click_on I18n.t('views.home.sign_up')
        end

        # Assert 
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.logout'))
        end
    end

end
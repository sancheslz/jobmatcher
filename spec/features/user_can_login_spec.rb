require 'rails_helper'

feature('User can login') do

    scenario('see option on homepage') do
        # Arrange
        user = User.create!(
            email: 'user@gmail.com',
            password: 'user1234'
        )

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_link(I18n.t('views.home.sign_in'))
        end
    end

    scenario('see the form') do
        # Arrange
        user = User.create!(
            email: 'user@gmail.com',
            password: 'user1234'
        )

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_in')
        end

        # Assert
        expect(current_path).to eq(new_user_session_path)
    end

    scenario('fields are required') do
        # Arrange
        user = User.create!(
            email: 'user@gmail.com',
            password: 'user1234'
        )

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_in')
        end
        within('form') do
            click_button I18n.t('views.home.sign_in')
        end

        # Assert
        expect(page).to have_content(I18n.t('devise.failure.invalid', authentication_keys: I18n.t('activerecord.attributes.user.email')))
    end

    scenario('with success') do
        # Arrange
        user = User.create!(
            email: 'user@gmail.com',
            password: 'user1234'
        )

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_in')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'user@gmail.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: 'user1234'
            click_button I18n.t('views.home.sign_in')
        end

        # Assert
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.logout'))
        end
    end

    scenario('returns to homepage') do
        # Arrange
        user = User.create!(
            email: 'user@gmail.com',
            password: 'user1234'
        )
        profile = Profile.create!(
            name: 'Simple User',
            cpf: '1234',
            user: user
        )

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_in')
        end
        within('form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'user@gmail.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: 'user1234'
            click_button I18n.t('views.home.sign_in')
        end

        # Assert
        expect(current_path).to eq(root_path)
    end

end
require 'rails_helper'

feature('User can login') do

    scenario('see button on navbar') do
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_link(I18n.t('views.home.sign_in'))
        end
    end

    scenario('see the login form') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
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
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_in')
        end
        within('div.container form') do
            click_button I18n.t('views.home.sign_in')
        end

        # Assert
        expect(page).to have_content(I18n.t('devise.failure.invalid', authentication_keys: I18n.t('activerecord.attributes.user.email')))
    end

    scenario('with success') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_in')
        end
        within('div.container form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'felismino.daconceicao@gmail.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: 'yellowtiger502'
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

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.sign_in')
        end
        within('div.container form') do
            fill_in I18n.t('activerecord.attributes.user.email'), with: 'felismino.daconceicao@gmail.com'
            fill_in I18n.t('activerecord.attributes.user.password'), with: 'yellowtiger502'
            click_button I18n.t('views.home.sign_in')
        end

        # Assert
        expect(current_path).to eq(root_path)
    end

end
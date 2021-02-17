require 'rails_helper'

feature('New user must fill a profile') do

    scenario('is redirect to profile form') do
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
        expect(current_path).to eq(new_profile_path)
    end

    scenario('see form errors') do
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

        fill_in I18n.t('activerecord.attributes.profile.name'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: ''
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 2) 
        
    end

    scenario('can\'t access other paths until finish') do
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

        fill_in I18n.t('activerecord.attributes.profile.name'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: ''
        click_on I18n.t('views.profiles.new_submit')
        visit root_path

        # Assert
        expect(current_path).to eq(new_profile_path)
    end

end
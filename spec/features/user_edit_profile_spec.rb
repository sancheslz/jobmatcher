require 'rails_helper'

# TODO: Implement access from home page
feature('User edit profile') do

    scenario('see the button') do
        # Arrange
        user = User.create!(
            email: 'user@gmail.com',
            password: '123456'
        )

        profile = Profile.create!(
            name: 'John Smith',
            cpf: '12345678910',
            bio: 'John Smith rocks',
            address: 'Avenue Saint Joseph',
            number: '123',
            complement: '',
            neighborhood: 'Amazing Landscape',
            city: 'Neverland',
            state: 'SP',
            postal_code: '1233345',
            user: user
        )

        login_as user

        # Act
        visit profile_path(profile)
        
        # Assert
        expect(page).to have_link(I18n.t('views.main.edit')) 
    end

    scenario('some fields are required') do
        # Arrange
        user = User.create!(
            email: 'user@gmail.com',
            password: '123456'
        )

        profile = Profile.create!(
            name: 'John Smith',
            cpf: '12345678910',
            bio: 'John Smith rocks',
            address: 'Avenue Saint Joseph',
            number: '123',
            complement: '',
            neighborhood: 'Amazing Landscape',
            city: 'Neverland',
            state: 'SP',
            postal_code: '1233345',
            user: user
        )

        login_as user

        # Act
        visit profile_path(profile)
        click_on I18n.t('views.main.edit')
        
        fill_in I18n.t('activerecord.attributes.profile.name'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: ''
        click_on I18n.t('views.profiles.edit_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 2) 
    end

    scenario('cpf must be unique') do
        # Arrange
        other = User.create!(
            email: 'otherr@gmail.com',
            password: '123456'
        )
        user = User.create!(
            email: 'user@gmail.com',
            password: '123456'
        )

        Profile.create!(
            name: 'John Snow',
            cpf: '02345678910',
            bio: 'John Snow rocks',
            address: 'Avenue Saint Joseph',
            number: '123',
            complement: '',
            neighborhood: 'Amazing Landscape',
            city: 'Neverland',
            state: 'SP',
            postal_code: '1233345',
            user: other
        )
        profile = Profile.create!(
            name: 'John Smith',
            cpf: '12345678910',
            bio: 'John Smith rocks',
            address: 'Avenue Saint Joseph',
            number: '123',
            complement: '',
            neighborhood: 'Amazing Landscape',
            city: 'Neverland',
            state: 'SP',
            postal_code: '1233345',
            user: user
        )

        login_as user

        # Act
        visit profile_path(profile)
        click_on I18n.t('views.main.edit')

        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '02345678910'
        click_on I18n.t('views.profiles.edit_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.taken'), count: 1)
    end

    scenario('with success') do
        # Arrange
        user = User.create!(
            email: 'user@gmail.com',
            password: '123456'
        )
        profile = Profile.create!(
            name: 'John Smith',
            cpf: '12345678910',
            bio: 'John Smith rocks',
            address: 'Avenue Saint Joseph',
            number: '123',
            complement: '',
            neighborhood: 'Amazing Landscape',
            city: 'Neverland',
            state: 'SP',
            postal_code: '1233345',
            user: user
        )

        login_as user

        # Act
        visit profile_path(profile)
        click_on I18n.t('views.main.edit')

        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'John Knife'
        click_on I18n.t('views.profiles.edit_submit')

        # Assert
        expect(current_path).to eq(profile_path(profile))
    end

end
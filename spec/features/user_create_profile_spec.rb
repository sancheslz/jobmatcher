require 'rails_helper'

# TODO: Implement access from home page
feature('User create a profile') do

    scenario('see page\'s title') do
        # Arrange

        # Act
        visit new_profile_path

        # Assert
        expect(page).to have_content(I18n.t('views.profiles.new_title'))
    end

    scenario('see the fields') do
        # Arrange

        # Act
        visit new_profile_path

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
    end

    scenario('some are required') do
        # Arrange

        # Act
        visit new_profile_path
        fill_in I18n.t('activerecord.attributes.profile.name'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.bio'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.address'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.number'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.complement'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.neighborhood'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.city'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.state'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.postal_code'), with: ''
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 2) 
    end

    scenario('cpf must be unique') do
        # Arrange
        Profile.create!(
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
        )

        # Act
        visit new_profile_path
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '12345678910'
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.taken'), count: 1)
    end

    scenario('create with success') do
        # Arrange

        # Act
        visit new_profile_path
        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'John Smith'
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '12345678910'
        fill_in I18n.t('activerecord.attributes.profile.bio'), with: 'John Smith rocks'
        fill_in I18n.t('activerecord.attributes.profile.address'), with: 'Avenue Saint Joseph'
        fill_in I18n.t('activerecord.attributes.profile.number'), with: '123'
        fill_in I18n.t('activerecord.attributes.profile.complement'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.neighborhood'), with: 'Amazing Landscape'
        fill_in I18n.t('activerecord.attributes.profile.city'), with: 'Neverland'
        fill_in I18n.t('activerecord.attributes.profile.state'), with: 'SP'
        fill_in I18n.t('activerecord.attributes.profile.postal_code'), with: '1233345'
        click_on I18n.t('views.profiles.new_submit')

        profile = Profile.last

        # Assert
        expect(current_path).to eq(profile_path(profile))
    end

end
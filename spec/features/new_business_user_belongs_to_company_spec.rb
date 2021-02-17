require 'rails_helper'

feature('New business user belongs to a company') do

    scenario('regular user register') do
        # Arrange
        user = User.create!(
            email: 'regular@gmail.com',
            password: 'regular1234'
        )
        
        
        # Act
        login_as user
        visit root_path
        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'Regular User'
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '123'
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(current_path).to eq(root_path)
        expect(Profile.last.role).to eq('regular')

    end
    

    scenario('first business user create company') do
        # Arrange
        user = User.create!(
            email: 'admin@campuscode.com',
            password: 'admin123'
        )
        
        # Act
        login_as user
        visit root_path
        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'Regular User'
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '123'
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(current_path).to eq(new_company_path)
        expect(Profile.last.role).to eq('admin')
    end


    scenario('other business user belongs to a company') do
        # Arrange
        first_user = User.create!(
            email: 'first@campuscode.com',
            password: 'first1234'
        )
        Profile.create!(
            name: 'First Business User',
            cpf: '1234',
            user: first_user,
            role: 'admin'
        )

        user = User.create!(
            email: 'usern@campuscode.com',
            password: 'user123'
        )
        
        # Act
        login_as user
        visit root_path
        fill_in I18n.t('activerecord.attributes.profile.name'), with: 'Second Business User'
        fill_in I18n.t('activerecord.attributes.profile.cpf'), with: '123'
        click_on I18n.t('views.profiles.new_submit')

        # Assert
        expect(current_path).to eq(root_path)
        expect(Profile.last.role).to eq('business')
    end
end
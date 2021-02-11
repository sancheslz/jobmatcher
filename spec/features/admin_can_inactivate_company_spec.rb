require 'rails_helper'

# TODO: implement access from root_path
feature('Admin can inactivate a company') do
    scenario('see the inactiave button on details') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1233456',
            address: 'My address',
            number: '1234',
            complement: 'BLC B',
            neighborhood: 'Paulista',
            city: 'São Paulo',
            state: 'SP',
            postal_code: '11345-345',
            website: 'www.campuscode.com',
            founded:  '2010', 
        )

        # Act
        visit company_path(company)

        # Assert
        expect(page).to have_link(I18n.t('views.companies.inactivate')) 
    end

    scenario('see the inactive messae') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1233456',
            address: 'My address',
            number: '1234',
            complement: 'BLC B',
            neighborhood: 'Paulista',
            city: 'São Paulo',
            state: 'SP',
            postal_code: '11345-345',
            website: 'www.campuscode.com',
            founded:  '2010', 
        )

        # Act
        visit company_path(company)
        click_on I18n.t('views.companies.inactivate')

        # Assert
        expect(page).to have_content(I18n.t('views.companies.inactive_message'))
    end

    scenario('have a reactivate button') do 
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1233456',
            address: 'My address',
            number: '1234',
            complement: 'BLC B',
            neighborhood: 'Paulista',
            city: 'São Paulo',
            state: 'SP',
            postal_code: '11345-345',
            website: 'www.campuscode.com',
            founded:  '2010', 
        )

        # Act
        visit company_path(company)
        click_on I18n.t('views.companies.inactivate')

        # Assert
        expect(page).to have_link(I18n.t('views.companies.reactivate'))
    end

    scenario('can reactivate') do 
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1233456',
            address: 'My address',
            number: '1234',
            complement: 'BLC B',
            neighborhood: 'Paulista',
            city: 'São Paulo',
            state: 'SP',
            postal_code: '11345-345',
            website: 'www.campuscode.com',
            founded:  '2010', 
        )

        # Act
        visit company_path(company)
        click_on I18n.t('views.companies.inactivate')
        click_on I18n.t('views.companies.reactivate')

        # Assert
        expect(page).not_to have_link(I18n.t('views.companies.inactive_message'))
    end

    scenario('can\'t edit inactive companies') do
        # Arrange
        company = Company.create!(
            name: 'Campus Code',
            cnpj: '1233456',
            address: 'My address',
            number: '1234',
            complement: 'BLC B',
            neighborhood: 'Paulista',
            city: 'São Paulo',
            state: 'SP',
            postal_code: '11345-345',
            website: 'www.campuscode.com',
            founded:  '2010', 
        )

        # Act
        visit company_path(company)
        click_on I18n.t('views.companies.inactivate')

        # Assert
        expect(page).not_to have_link(I18n.t('views.main.edit'))
    end
end
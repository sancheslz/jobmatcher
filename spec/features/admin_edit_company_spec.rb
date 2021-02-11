require 'rails_helper'

# TODO: implement access from root_path
feature('Admin edit company') do

    scenario('some fields are required') do
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
        visit edit_company_path(company)
        fill_in I18n.t('activerecord.attributes.company.name'), with: ''
        fill_in I18n.t('activerecord.attributes.company.cnpj'), with: ''
        fill_in I18n.t('activerecord.attributes.company.address'), with: ''
        fill_in I18n.t('activerecord.attributes.company.number'), with: ''
        fill_in I18n.t('activerecord.attributes.company.complement'), with: ''
        fill_in I18n.t('activerecord.attributes.company.neighborhood'), with: ''
        fill_in I18n.t('activerecord.attributes.company.city'), with: ''
        fill_in I18n.t('activerecord.attributes.company.state'), with: ''
        fill_in I18n.t('activerecord.attributes.company.postal_code'), with: ''
        fill_in I18n.t('activerecord.attributes.company.website'), with: ''
        fill_in I18n.t('activerecord.attributes.company.founded'), with: ''
        click_on I18n.t('views.companies.edit_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 3) 
    end

    scenario('cnpj must be unique') do
        # Arrange
        Company.create!(
            name: 'Rails Brasil',
            cnpj: '2233456',
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
        visit edit_company_path(company)
        fill_in I18n.t('activerecord.attributes.company.cnpj'), with: '2233456'
        click_on I18n.t('views.companies.edit_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.taken')) 
    end

    scenario('update with success') do
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
        visit edit_company_path(company)
        fill_in I18n.t('activerecord.attributes.company.website'), with: 'https://www.campuscode.com'
        click_on I18n.t('views.companies.edit_submit')

        # Assert
        expect(current_path).to eq(company_path(company))
    end

end
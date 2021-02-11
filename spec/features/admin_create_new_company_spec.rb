require 'rails_helper'

# TODO: implement access from root_path
feature('Admin create a new company') do
    scenario('see section title') do
        # Arrange

        # Act
        visit new_company_path

        # Assert
        expect(page).to have_content(I18n.t('views.companies.new_title')) 
    end
    
    scenario('available fields') do
        # Arrange

        # Act
        visit new_company_path

        # Assert
        within('form') do
            expect(page).to have_content(I18n.t('activerecord.attributes.company.name')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.address')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.number')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.complement')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.neighborhood')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.city')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.state')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.postal_code')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.website')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.founded')) 
        end
    end
    
    scenario('some are required') do
        # Arrange

        # Act
        visit new_company_path
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
        click_on I18n.t('views.companies.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 3) 
    end
    
    scenario('cnpj must be unique') do
        # Arrange
        Company.create!(
            name: 'Lorem Name',
            cnpj: '123456789',
            website: 'www.loremname.com'
        )

        # Act
        visit new_company_path
        fill_in I18n.t('activerecord.attributes.company.name'), with: 'Ipsum name'
        fill_in I18n.t('activerecord.attributes.company.cnpj'), with: '123456789'
        fill_in I18n.t('activerecord.attributes.company.address'), with: ''
        fill_in I18n.t('activerecord.attributes.company.number'), with: ''
        fill_in I18n.t('activerecord.attributes.company.complement'), with: ''
        fill_in I18n.t('activerecord.attributes.company.neighborhood'), with: ''
        fill_in I18n.t('activerecord.attributes.company.city'), with: ''
        fill_in I18n.t('activerecord.attributes.company.state'), with: ''
        fill_in I18n.t('activerecord.attributes.company.postal_code'), with: ''
        fill_in I18n.t('activerecord.attributes.company.website'), with: 'www.ipsumname.com'
        fill_in I18n.t('activerecord.attributes.company.founded'), with: ''
        click_on I18n.t('views.companies.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.taken')) 
    end
    
    scenario('create with success') do
        # Arrange

        # Act
        visit new_company_path
        fill_in I18n.t('activerecord.attributes.company.name'), with: 'Ipsum name'
        fill_in I18n.t('activerecord.attributes.company.cnpj'), with: '123456789'
        fill_in I18n.t('activerecord.attributes.company.website'), with: 'www.ipsumname.com'
        click_on I18n.t('views.companies.new_submit')

        # Assert
        company = Company.last
        expect(current_path).to eq(company_path(company))
    end
end
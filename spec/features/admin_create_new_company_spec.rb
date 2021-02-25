require 'rails_helper'

feature('Admin create a new company') do

    scenario('see section title') do
        # Arrange
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )
        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user 

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(I18n.t('views.companies.new_title')) 
    end
    
    scenario('available fields') do
        # Arrange
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )
        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user 

        # Act
        visit root_path

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
            expect(page).to have_content(I18n.t('activerecord.attributes.company.facebook')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.linkedin')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.instagram')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.youtube')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.founded')) 
            expect(page).to have_content(I18n.t('activerecord.attributes.company.logo')) 
        end
    end
    
    scenario('some are required') do
        # Arrange
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )
        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user 

        # Act
        visit root_path
        fill_in I18n.t('activerecord.attributes.company.name'), with: ''
        fill_in I18n.t('activerecord.attributes.company.cnpj'), with: ''
        fill_in I18n.t('activerecord.attributes.company.website'), with: ''
        click_on I18n.t('views.companies.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 3) 
    end
    
    scenario('cnpj must be unique') do
        # Arrange
        other_company = Company.create!(
            name: 'MoemaSoft',
            cnpj: '815.916.474/1594-96',
            address: 'Rua São Sebastiao',
            number: '8',
            complement: 'Park',
            city: 'Caxias',
            state: 'Alagoas',
            postal_code: '56170',
            website: 'www.moemasoft.com',
            founded:'1983',
        )

        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )
        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user 

        # Act
        visit root_path
        fill_in I18n.t('activerecord.attributes.company.cnpj'), with: '815.916.474/1594-96'
        click_on I18n.t('views.companies.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.taken')) 
    end
    
    scenario('create with success') do
        # Arrange
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )
        Profile.create!(
            name: 'Graciliana Novaes',
            cpf: '388.586.242-26',
            address: 'Rua Quatro',
            number: '8229',
            complement: '-', 
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '75674',
            role: 'admin',
            user: user
        )

        login_as user 

        # Act
        visit root_path
        fill_in I18n.t('activerecord.attributes.company.name'), with: 'Continuous Development'
        fill_in I18n.t('activerecord.attributes.company.cnpj'), with: '832.538.794/9328-87'
        fill_in I18n.t('activerecord.attributes.company.website'), with: 'www.cdev.com'
        attach_file I18n.t('activerecord.attributes.company.logo'), Rails.root.join('spec', 'support', 'cd_logo.png')
        click_on I18n.t('views.companies.new_submit')

        # Assert
        company = Company.last
        expect(current_path).to eq(company_path(company))
    end
end
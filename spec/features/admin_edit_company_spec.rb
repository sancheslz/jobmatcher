require 'rails_helper'

feature('Admin edit company') do

    scenario('have the edition button') do
        # Arrange
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end

        # Assert
        expect(page).to have_link(I18n.t('views.main.edit'))
    end

    scenario('access the edit form') do
        # Arrange
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user
        
        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end
        click_on I18n.t('views.main.edit')

        # Assert
        expect(current_path).to eq(edit_company_path(company))
    end

    scenario('some fields are required') do
        # Arrange
        user = User.create!(
            email: 'graciliana.novaes@cdev.com',
            password: 'brownbird755'
        )

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end
        click_on I18n.t('views.main.edit')

        within('form') do
            fill_in I18n.t('activerecord.attributes.company.name'), with: ''
            fill_in I18n.t('activerecord.attributes.company.cnpj'), with: ''
            fill_in I18n.t('activerecord.attributes.company.website'), with: ''
            click_on I18n.t('views.companies.edit_submit')
        end

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

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end
        click_on I18n.t('views.main.edit')
        
        within('form') do
            fill_in I18n.t('activerecord.attributes.company.cnpj'), with: '815.916.474/1594-96'
            click_on I18n.t('views.companies.edit_submit')
        end

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.taken')) 
    end

    scenario('can\'t edit an inactive company') do
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

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
            is_active: false
        )

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end

        # Assert
        expect(page).not_to have_link(I18n.t('views.main.edit'))
    end

    scenario('can\'t access edit url of inactive companies') do
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

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
            is_active: false
        )

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit edit_company_path(company.reload)

        # Assert
        expect(current_path).to eq(root_path)
    end

    scenario('can set a logo') do
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

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end
        click_on I18n.t('views.main.edit')
        
        within('form') do
            attach_file I18n.t('activerecord.attributes.company.logo'), Rails.root.join('spec', 'support', 'cd_logo.png')
            click_on I18n.t('views.companies.edit_submit')
        end

        # Assert
        expect(page).to have_css('img[@src*="cd_logo.png"]')
    end

    scenario('update with success') do
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

        profile = Profile.create!(
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

        company = Company.create!(
            name: 'Continuous Development',
            cnpj: '832.538.794/9328-87',
            address: 'Rio Grande do Sul',
            number: '347',
            complement: 'Center',
            city: 'Resende',
            state: 'Roraima', 
            postal_code: '85390',
            website: 'www.cdev.com',
            founded:'2009',
        )

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user
        
        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end
        click_on I18n.t('views.main.edit')
        
        within('form') do
            fill_in I18n.t('activerecord.attributes.company.founded'), with: '2010'
            click_on I18n.t('views.companies.edit_submit')
        end

        # Assert
        expect(current_path).to eq(company_path(company))
    end

end
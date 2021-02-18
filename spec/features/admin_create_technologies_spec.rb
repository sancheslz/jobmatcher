require 'rails_helper'

feature('Admin create technologies') do

    scenario('have option on menu') do
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
        end
        
        # Assert
        within('nav') do
            expect(page).to have_link(I18n.t('views.technologies.title'))
        end
    end

    scenario('can register a new one') do
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
            click_on I18n.t('views.technologies.title')
        end
        
        # Assert
        expect(page).to have_link(I18n.t('views.technologies.new_title'))
    end

    scenario('access the form') do
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
            click_on I18n.t('views.technologies.title')
        end
        click_on I18n.t('views.technologies.new_title')
        
        # Assert
        expect(current_path).to eq(new_technology_path)
    end

    scenario('field is required') do
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
            click_on I18n.t('views.technologies.title')
        end
        click_on I18n.t('views.technologies.new_title')
        
        fill_in I18n.t('activerecord.attributes.technology.name'), with: ''
        click_on I18n.t('views.technologies.new_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'))
    end

    scenario('create with success') do
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
            click_on I18n.t('views.technologies.title')
        end
        click_on I18n.t('views.technologies.new_title')
        
        fill_in I18n.t('activerecord.attributes.technology.name'), with: ''
        click_on I18n.t('views.technologies.new_submit')

        fill_in I18n.t('activerecord.attributes.technology.name'), with: 'Ruby'
        click_on I18n.t('views.technologies.new_submit')

        technologies = Technology.last

        # Assert
        expect(page).to have_content(technologies.name)
    end
end



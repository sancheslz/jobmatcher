require 'rails_helper'

feature('Admin see company details') do


    scenario('have the company button on menu') do
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

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
        end

        # Assert
        expect(page).to have_link(I18n.t('views.companies.mine')) 
    end

    scenario('there is a title') do
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

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
        end
        click_on I18n.t('views.companies.mine')

        # Assert
        expect(page).to have_content(I18n.t('views.companies.detail_title'))
    end

    scenario('all fields are displayed') do
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

        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
        end
        click_on I18n.t('views.companies.mine')

        # Assert
        expect(page).to have_content(company.name)
        expect(page).to have_content(company.cnpj)
        expect(page).to have_content(company.address)
        expect(page).to have_content(company.number)
        expect(page).to have_content(company.complement)
        expect(page).to have_content(company.neighborhood)
        expect(page).to have_content(company.city)
        expect(page).to have_content(company.state)
        expect(page).to have_content(company.postal_code)
        expect(page).to have_content(company.website)
        expect(page).to have_content(company.founded)
    end

end
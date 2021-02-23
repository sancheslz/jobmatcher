require 'rails_helper'

feature('Visitor see all companies') do
    
    scenario('see the button on home') do
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_link(I18n.t('views.companies.list'))
    end

    scenario('goes to the right path') do
        # Arrange

        # Act
        visit root_path
        click_on I18n.t('views.companies.list')

        # Assert
        expect(current_path).to eq(companies_path)
    end

    scenario('see the company name') do
        # Arrange
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

        # Act
        visit root_path
        click_on I18n.t('views.companies.list')
        
        # Assert
        expect(page).to have_content(company.name)
    end

    scenario('see the amount of opportunities') do
        # Arrange
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

        Opportunity.create!(
            title: "Desenvolvedor(a) Front End",
            description: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.},
            requirement: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 8000,
            remote: true,
            level: :mid,
            company: company,
            is_visible: true,
        )

        # Act
        visit root_path
        click_on I18n.t('views.companies.list')
        
        # Assert
        expect(page).to have_content("#{I18n.t('views.companies.opportunities')}: #{company.active_opportunities}")
    end

    scenario('can see company details') do
        # Arrange
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

        Opportunity.create!(
            title: "Desenvolvedor(a) Front End",
            description: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.},
            requirement: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 8000,
            remote: true,
            level: :mid,
            company: company,
            is_visible: true,
        )

        # Act
        visit root_path
        click_on I18n.t('views.companies.list')
        click_on company.name
        
        # Assert
        expect(current_path).to eq(company_path(company))
    end
end
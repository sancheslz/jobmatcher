require 'rails_helper'

feature('Visitor see details from home page') do
    
    scenario('have company access link') do
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

        opportunity = Opportunity.create!(
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

        # Assert
        within("div#opportunity_#{opportunity.reload.id}") do
            expect(page).to have_link(company.name)
        end
        
    end

    scenario('access company details') do
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

        opportunity = Opportunity.create!(
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
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on company.name
        end
        
        # Assert
        expect(current_path).to eq(company_path(company))
        
    end

    scenario('have opportunity access link') do
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

        opportunity = Opportunity.create!(
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

        # Assert
        within("div#opportunity_#{opportunity.reload.id}") do
            expect(page).to have_link(I18n.t('views.home.more'))
        end
        
    end

    scenario('access company details') do
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

        opportunity = Opportunity.create!(
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
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.home.more')
        end

        # Assert
        expect(current_path).to eq(opportunity_path(opportunity))
        
    end

    scenario('opportunity details has link to company') do
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

        opportunity = Opportunity.create!(
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
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.home.more')
        end

        # Assert
        expect(page).to have_link(company.name)
        
    end

end
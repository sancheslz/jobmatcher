require 'rails_helper'

feature('Visitor sees on home') do

    scenario('the title in the navbar') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.title'))
        end
    end

    scenario('the title in the jumbotron') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('div.jumbotron') do
            expect(page).to have_content(I18n.t('views.home.title'))
        end
    end
    
    scenario('a short description') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('div.jumbotron') do
            expect(page).to have_content(I18n.t('views.home.description'))
        end
    end

    scenario('last opportunities section title') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(I18n.t('views.home.last_opportunities'))
    end

    scenario('a message if no opportunities founded') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(I18n.t('views.home.empty'))
    end

    scenario('the opportunity if it exists') do 
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
        expect(page).to have_content(opportunity.title)
        expect(page).to have_content(opportunity.description)
        expect(page).to have_content(opportunity.company.name)
    end

    scenario('only active opportunities') do 
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

        opportunity_active = Opportunity.create!(
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

        opportunity_inactive = Opportunity.create!(
            title: "Desenvolvedor(a) Front-end Sênior",
            description: %{A Vaga é para desenvolvedor Sênior, porém estamos contratando para todos os níveis. Havendo sinergia com as informações abaixo, sinta-se a vontade para entrar em contato. >> Desenvolvimento de aplicações web | Integrações entre sistemas. >> Diferenciais: Experiência com desenvolvimento no mercado de capitaisl; Experiência com desenvolvimento no mercado agro; Conhecimento em Flutter},
            requirement: %{Mínimo de 5 anos de experiência com desenvolvimento de aplicações web | Conhecimentos sólidos em Estruturas de Dados e APIs | Orientação a objetos e atenção plena a qualidade de código | Boa comunicação e capacidade para trabalhar em equipe para assimilar problemas e discutir soluções | REST | SCRUM | VUEJS},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 12000,
            remote: true,
            level: :senior,
            company: company,
            is_visible: false,
        )

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(opportunity_active.title)
        expect(page).to have_content(opportunity_active.description)

        expect(page).not_to have_content(opportunity_inactive.title)
        expect(page).not_to have_content(opportunity_inactive.description)
    end

    scenario('opportunity info') do
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

        technology_first = Technology.create!( name: 'JavaScript' )
        technology_second = Technology.create!( name: 'TypeScript' )

        TechnologyOpportunity.create!(
            technology: technology_first,
            opportunity: opportunity
        )
        
        TechnologyOpportunity.create!(
            technology: technology_second,
            opportunity: opportunity
        )

        # Act
        visit root_path

        # Assert
        expect(page).to have_content(opportunity.title)
        expect(page).to have_content(opportunity.description)
        expect(page).to have_content(opportunity.company.name)
        expect(page).to have_content(technology_first.name)
        expect(page).to have_content(technology_second.name)

        expect(page).to have_link(opportunity.company.name)
        expect(page).to have_link(I18n.t('views.home.more'))

    end

    scenario('a search field') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_field(placeholder: I18n.t('views.home.search')) 
        end
    end

    scenario('a search button') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.search_btn'))
        end
    end

    scenario('a sign in button') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.sign_in'))
        end
    end

    scenario('a sign up button') do 
        # Arrange

        # Act
        visit root_path

        # Assert
        within('nav') do
            expect(page).to have_content(I18n.t('views.home.sign_up'))
        end
    end

end
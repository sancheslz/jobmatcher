require 'rails_helper'

feature('User can search for company and opportunities') do
    
    scenario('send empty form') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            click_on I18n.t('views.home.search_btn')    
        end

        # Assert
        expect(page).to have_content(I18n.t('views.home.search_company_empty'))
    end
    
    scenario('send empty form for companies') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            select I18n.t('views.home.company')
            click_on I18n.t('views.home.search_btn')    
        end

        # Assert
        expect(page).to have_content(I18n.t('views.home.search_company_empty'))
    end
    
    scenario('send empty form for opportunities') do
        # Arrange

        # Act
        visit root_path
        within('nav') do
            select I18n.t('views.home.opportunity')
            click_on I18n.t('views.home.search_btn')    
        end

        # Assert
        expect(page).to have_content(I18n.t('views.home.search_opportunity_empty'))
    end

    scenario('search for companies') do
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
        within('nav') do
            fill_in I18n.t('views.home.search'), with: 'cont'
            select I18n.t('views.home.company')
            click_on I18n.t('views.home.search_btn')    
        end

        # Assert
        expect(page).to have_link(company.name)
    end

    scenario('search for opportunity') do
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
        within('nav') do
            fill_in I18n.t('views.home.search'), with: 'front'
            select I18n.t('views.home.opportunity')
            click_on I18n.t('views.home.search_btn')    
        end

        # Assert
        expect(page).to have_link(opportunity.title)
    end
    
end
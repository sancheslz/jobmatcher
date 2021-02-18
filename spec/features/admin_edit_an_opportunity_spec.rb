require 'rails_helper'

feature('Admin edit an opportunity') do

    scenario('has the edit button') do
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

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end

        # Assert
        within("div#opportunity_#{opportunity.reload.id}") do
            expect(page).to have_link(I18n.t('views.main.edit'))
        end
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

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end
        
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.main.edit')
        end

        # Assert
        expect(current_path).to eq(edit_opportunity_path(opportunity))
    end

    scenario('required fields can\'t be blank') do
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

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end
        
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.main.edit')
        end

        fill_in I18n.t('activerecord.attributes.opportunity.title'), with: ''
        fill_in I18n.t('activerecord.attributes.opportunity.description'), with: ''
        fill_in I18n.t('activerecord.attributes.opportunity.requirement'), with: ''
        click_on I18n.t('views.opportunities.edit_submit')

        # Assert
        expect(page).to have_content(I18n.t('errors.messages.blank'), count: 3)
    end

    scenario('update with success') do
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

        CompanyProfile.create!( profile: profile, company: company )
        
        login_as user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.companies.mine')
        end
        
        within("div#opportunity_#{opportunity.reload.id}") do
            click_on I18n.t('views.main.edit')
        end

        fill_in I18n.t('activerecord.attributes.opportunity.title'), with: 'Desenvolvedor React'
        click_on I18n.t('views.opportunities.edit_submit')

        # Assert
        within("div#opportunity_#{opportunity.id}") do
            expect(page).not_to have_content(opportunity.title)
            expect(page).to have_content(opportunity.reload.title)
        end
    end

end
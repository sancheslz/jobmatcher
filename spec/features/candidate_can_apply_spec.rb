require 'rails_helper'

feature('Candidate can apply to an opportunity') do
    
    # Create the opportunity on the test database
    before(:each) do

        @technology_first = Technology.create!( name: 'JavaScript' )
        @technology_second = Technology.create!( name: 'TypeScript' )
    
        @company = Company.create!(
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
    
        @opportunity = Opportunity.create!(
            title: "Desenvolvedor(a) Front End",
            description: %{Você será responsável por desenvolver interfaces web a partir de especificações realizadas pelo time de design primariamente utilizando ReactJs mas também atendendo demandas de desenvolvimento e manutenção em sistemas desenvolvidos com React Native.},
            requirement: %{Grande conhecimento em desenvolvimento ReactJs | Habilidade para desenvolver em Typescript | Experiência em desenvolvimento React Native | Capacidade de escrever código limpo e bem documentado | Conhecimento em Hooks, TDD, Clean Architecture, SOLID},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 8000,
            remote: true,
            level: :mid,
            company: @company,
            is_visible: true,
        )
    
        @tech_opportunity = TechnologyOpportunity.create!( technology: @technology_first, opportunity: @opportunity )
        @tech_opportunity = TechnologyOpportunity.create!( technology: @technology_second, opportunity: @opportunity )
    
    end

    scenario('see the apply button on opportunity card') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path
        
        # Assert
        @opportunity.reload
        within("div#opportunity_#{@opportunity.id}") do
            expect(page).to have_link(I18n.t('views.applications.apply'))
        end
    end

    scenario('goes to the application path') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path
        
        @opportunity.reload
        within("div#opportunity_#{@opportunity.id}") do
            click_on I18n.t('views.applications.apply')
        end
        
        # Assert
        expect(current_path).to eq(new_application_path)
    end

    scenario('see opportunity details') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path

        @opportunity.reload
        within("div#opportunity_#{@opportunity.id}") do
            click_on I18n.t('views.applications.apply')
        end
        
        # Assert
        expect(page).to have_content(@opportunity.title)
        expect(page).to have_content(@opportunity.description)
        expect(page).to have_content(@opportunity.requirement)
        expect(page).to have_content(@opportunity.position_quantity)
        expect(page).to have_content(@opportunity.expiration_date)
        expect(page).to have_content(@opportunity.salary)
        expect(page).to have_content(@opportunity.remote)
        expect(page).to have_content(@opportunity.level)
        expect(page).to have_content(@opportunity.company.name)
    end

    scenario('have fields to fill') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path

        @opportunity.reload
        within("div#opportunity_#{@opportunity.id}") do
            click_on I18n.t('views.applications.apply')
        end

        # Assert
        within('form') do
            expect(page).to have_field(I18n.t('activerecord.attributes.applications.presentation')) 
            expect(page).to have_field(I18n.t('activerecord.attributes.applications.wage_claim')) 
            expect(page).to have_field(I18n.t('activerecord.attributes.applications.note')) 
        end
    end

    scenario('some are required') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path

        @opportunity.reload
        within("div#opportunity_#{@opportunity.id}") do
            click_on I18n.t('views.applications.apply')
        end
        
        within('form') do
            click_on I18n.t('views.applications.apply')
        end

        # Assert
        expect(page).to have_field(I18n.t('errors.messages.blank'), count: 2)
    end

    scenario('create with success') do
        # Arrange
        user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit root_path

        @opportunity.reload
        within("div#opportunity_#{@opportunity.id}") do
            click_on I18n.t('views.applications.apply')
        end
        
        within('form') do
            fill_in I18n.t('activerecord.attributes.applications.presentation'), with: %{Tenho 10 anos de experiência como Engenheiro de Produção em uma empresa de grande porte, atuei no controle logístico, de produção e gerência. Estou em transição de carreira para a área de desenvolvimento de software. Tenho experiência com JavaScript, React, Angular, Vue e PHP}
            fill_in I18n.t('activerecord.attributes.applications.wage_claim'), with: 7000
            click_on I18n.t('views.applications.apply')
        end

        # Assert
        expect(current_path).to eq(opportunity_path(@opportunity))
        expect(page).to have_content(I18n.t('views.applications.applied'))
    end

end
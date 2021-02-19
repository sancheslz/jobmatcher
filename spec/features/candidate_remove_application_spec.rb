require 'rails_helper'

feature('Candidate remove application') do

    before(:each) do
        @user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

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
    
    end

    scenario('see the button on the home') do
        # Arrange
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
            user: @user
        )
        
        @submission = Submission.create!(
            opportunity: @opportunity,
            profile: profile,
            wage_claim: 7000,
            presentation: %{Tenho 10 anos de experiência como Engenheiro de Produção em uma empresa de grande porte, atuei no controle logístico, de produção e gerência. Estou em transição de carreira para a área de desenvolvimento de software. Tenho experiência com JavaScript, React, Angular, Vue e PHP},
            status: :applied
        )
        
        login_as @user

        # Act
        visit root_path

        # Assert
        within("div#opportunity_#{@opportunity.id}") do
            expect(page).to have_link(I18n.t('views.submissions.unapply'))
            expect(page).not_to have_link(I18n.t('views.submissions.apply'))
        end
    end

    scenario('see a warning message') do
        # Arrange
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
            user: @user
        )
        
        @submission = Submission.create!(
            opportunity: @opportunity,
            profile: profile,
            wage_claim: 7000,
            presentation: %{Tenho 10 anos de experiência como Engenheiro de Produção em uma empresa de grande porte, atuei no controle logístico, de produção e gerência. Estou em transição de carreira para a área de desenvolvimento de software. Tenho experiência com JavaScript, React, Angular, Vue e PHP},
            status: :applied
        )
        
        login_as @user
        
        # Act
        visit root_path
        within("div#opportunity_#{@opportunity.id}") do
            click_on I18n.t('views.submissions.unapply')
        end

        # Assert
        expect(current_path).to eq(remove_submission_path(@submission))
        expect(page).to have_content(I18n.t('views.submissions.warning'))
    end

    scenario('remove with success') do
        # Arrange
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
            user: @user
        )
        
        @submission = Submission.create!(
            opportunity: @opportunity,
            profile: profile,
            wage_claim: 7000,
            presentation: %{Tenho 10 anos de experiência como Engenheiro de Produção em uma empresa de grande porte, atuei no controle logístico, de produção e gerência. Estou em transição de carreira para a área de desenvolvimento de software. Tenho experiência com JavaScript, React, Angular, Vue e PHP},
            status: :applied
        )
        
        login_as @user
        
        # Act
        visit root_path
        within("div#opportunity_#{@opportunity.id}") do
            click_on I18n.t('views.submissions.unapply')
        end
        click_on I18n.t('views.main.confirm')

        # Assert
        within("div#opportunity_#{@opportunity.id}") do
            expect(page).not_to have_link(I18n.t('views.submissions.unapply'))
            expect(current_path).to eq(root_path)
        end
    end

end
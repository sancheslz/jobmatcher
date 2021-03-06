require 'rails_helper'

feature('Admin see applications') do 
    before(:each) do 
        @admin_user = User.create!(
            email: 'linton.araujos@moemasoft.com',
            password: 'crazybutterfly906'
        )

        @admin_profile = Profile.create!(
            name: 'Línton Araújo',
            cpf: '280.720.644-08',
            address: 'Rua Doze',
            number: '8',
            complement: 'Park',
            city: 'Caxias',
            state: 'Alagoas',
            postal_code: '88870',
            role: 'admin',
            user: @admin_user
        )

        @company = Company.create!(
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

        CompanyProfile.create!(
            profile: @admin_profile,
            company: @company, 
        )

        @opportunity = Opportunity.create!(
            title: "Programador(a) PHP",
            description: %{Desenvolvimento e manutenção de aplicações web | Realizar a manutenção e criação de novas funcionalidades | Desenvolvimento de funcionalidades no Back-End | Aplicar melhores práticas de documentação de código desenvolvido},
            requirement: %{Formação em ensino superior ou técnico | Experiência prévia nas linguagens informadas | Habilidades interpessoais de escrita e de comunicação verbal},
            position_quantity: 2,
            expiration_date: 30.days.from_now,
            salary: 2000,
            remote: false,
            level: :entry,
            company: @company,
            is_visible: true,
        )

        @candidate_user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        @candidate_profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: @candidate_user
        )

        Submission.create!(
            profile: @candidate_profile,
            opportunity: @opportunity,
            wage_claim: 2500,
            note: '',
            presentation: %{Tenho 10 anos de experiência como Engenheiro de Produção em uma empresa de grande porte, atuei no controle logístico, de produção e gerência. Estou em transição de carreira para a área de desenvolvimento de software. Tenho experiência com JavaScript, React, Angular, Vue e PHP},
            status: :applied
        )
    end

    scenario('can access from home menu') do
        # Arrange
        login_as @admin_user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
        end

        # Assert
        within('nav') do
            expect(page).to have_link(I18n.t('views.opportunities.mine'))
        end
    end

    scenario('see the opportunities') do
        # Arrange
        login_as @admin_user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.opportunities.mine')
        end

        # Assert
        opportunity = Opportunity.last
        expect(page).to have_content(opportunity.title)
    end

    scenario('but only valids and visibles') do
        # Arrange
        hidden_opportunity = Opportunity.create!(
            title: "Programador(a) Web Front End Pleno",
            description: %{Desenvolver melhorias e novas funcionalidades},
            requirement: %{Experiência com ferramentas de versionamento de código (GIT,...) | Experiência prévia nas linguagens informadas},
            position_quantity: 1,
            expiration_date: 30.days.from_now,
            salary: 5000,
            remote: true,
            level: :mid,
            company: @company,
            is_visible: false,
        )
        invalid_opportunity = Opportunity.create!(
            title: "Desenvolvedor(a) Front-end Sênior",
            description: %{A Vaga é para desenvolvedor Sênior, porém estamos contratando para todos os níveis. Havendo sinergia com as informações abaixo, sinta-se a vontade para entrar em contato. >> Desenvolvimento de aplicações web | Integrações entre sistemas. >> Diferenciais: Experiência com desenvolvimento no mercado de capitaisl; Experiência com desenvolvimento no mercado agro; Conhecimento em Flutter},
            requirement: %{Mínimo de 5 anos de experiência com desenvolvimento de aplicações web | Conhecimentos sólidos em Estruturas de Dados e APIs | Orientação a objetos e atenção plena a qualidade de código | Boa comunicação e capacidade para trabalhar em equipe para assimilar problemas e discutir soluções | REST | SCRUM | VUEJS},
            position_quantity: 1,
            expiration_date: 1.days.ago,
            salary: 12000,
            remote: true,
            level: :senior,
            company: @company,
            is_visible: true,
        )
        login_as @admin_user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.opportunities.mine')
        end

        # Assert
        opportunity = Opportunity.last
        expect(page).to have_content(@opportunity.title)
        expect(page).not_to have_content(hidden_opportunity.title)
        expect(page).not_to have_content(invalid_opportunity.title)
    end

    scenario('see how many candidates each opportunity have') do
        # Arrange
        login_as @admin_user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.opportunities.mine')
        end

        # Assert
        opportunity = Opportunity.last
        within("li#opportunity_#{opportunity.id}") do 
            expect(page).to have_css("span.candidates", text: opportunity.submissions.count)
        end
    end

    scenario('but don\'t see removed applications') do
        # Arrange
        submission = Submission.first
        submission.update(status: :removed)
        submission.save

        login_as @admin_user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.opportunities.mine')
        end

        # Assert
        opportunity = Opportunity.last
        within("li#opportunity_#{opportunity.id}") do 
            expect(page).to have_css("span.candidates", text: opportunity.count_valid)
            expect(page).not_to have_css("span.candidates", text: opportunity.submissions.count)
        end
    end

    scenario('see the list of candidates') do
        # Arrange
        login_as @admin_user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.opportunities.mine')
        end
        opportunity = Opportunity.last
        click_on opportunity.title

        # Assert
        expect(page).to have_content(@candidate_profile.name)
    end

    scenario('and its details') do
        # Arrange
        login_as @admin_user

        # Act
        visit root_path
        within('nav') do
            click_on 'Menu'
            click_on I18n.t('views.opportunities.mine')
        end
        opportunity = Opportunity.last
        click_on opportunity.title
        click_on @candidate_profile.name

        # Assert
        submission = Submission.first
        expect(page).to have_content(@candidate_profile.name)
        expect(page).to have_content('-')
        expect(page).to have_content(submission.presentation)
        expect(page).to have_content(submission.note)
    end
end 
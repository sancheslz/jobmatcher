require 'rails_helper'

feature('Admin appreciate a submission') do
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

        @submission = Submission.create!(
            profile: @candidate_profile,
            opportunity: @opportunity,
            wage_claim: 2500,
            note: '',
            presentation: %{Tenho 10 anos de experiência como Engenheiro de Produção em uma empresa de grande porte, atuei no controle logístico, de produção e gerência. Estou em transição de carreira para a área de desenvolvimento de software. Tenho experiência com JavaScript, React, Angular, Vue e PHP},
            status: :applied
        )    
    end

    context("accept") do
        
        scenario('see the "accept" button ') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name

            # Assert
            within("div#submission_#{@submission.id}") do
                expect(page).to have_link(I18n.t('views.offers.accept'))
            end
        end

        scenario('see the form') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.accept')
            end

            # Assert
            expect(page).to have_field((I18n.t('activerecord.attributes.offer.salary')))
            expect(page).to have_field((I18n.t('activerecord.attributes.offer.comment')))
            expect(page).to have_field((I18n.t('activerecord.attributes.offer.start_at')))
        end

        scenario('fiels are required') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.accept')
            end

            click_on I18n.t('views.main.send')

            # Assert
            expect(page).to have_content(I18n.t('errors.messages.blank'), count: 3)
        end

        scenario('with success') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.accept')
            end

            fill_in I18n.t('activerecord.attributes.offer.salary'), with: 2200
            fill_in I18n.t('activerecord.attributes.offer.comment'), with: 'Enviaremos um e-mail com o contrato e demais informações'
            fill_in I18n.t('activerecord.attributes.offer.start_at'), with: 10.days.from_now.strftime('%d/%m/%Y')
            click_on I18n.t('views.main.send')

            # Assert
            expect(current_path).to eq(application_list_opportunity_path(@submission.opportunity.id))
        end

        scenario('the candidate status is updated') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.accept')
            end

            fill_in I18n.t('activerecord.attributes.offer.salary'), with: 2200
            fill_in I18n.t('activerecord.attributes.offer.comment'), with: 'Enviaremos um e-mail com o contrato e demais informações'
            fill_in I18n.t('activerecord.attributes.offer.start_at'), with: 10.days.from_now.strftime('%d/%m/%Y')
            click_on I18n.t('views.main.send')

            # Assert
            within("div#submission_#{@submission.id}") do
                expect(page).to have_content(I18n.t('activerecord.attributes.submission.status_accepted'))
            end
        end

        scenario('can\'t appreciate again') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.accept')
            end

            fill_in I18n.t('activerecord.attributes.offer.salary'), with: 2200
            fill_in I18n.t('activerecord.attributes.offer.comment'), with: 'Enviaremos um e-mail com o contrato e demais informações'
            fill_in I18n.t('activerecord.attributes.offer.start_at'), with: 10.days.from_now.strftime('%d/%m/%Y')
            click_on I18n.t('views.main.send')

            # Assert
            within("div#submission_#{@submission.id}") do
                expect(page).not_to have_link(I18n.t('views.offers.accept'))
                expect(page).not_to have_link(I18n.t('views.offers.deny'))
            end
        end

    end

    context("deny") do
        
        scenario('see the "deny" button ') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name

            # Assert
            within("div#submission_#{@submission.id}") do
                expect(page).to have_link(I18n.t('views.offers.deny'))
            end
        end

        scenario('see the form') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.deny')
            end

            # Assert
            expect(page).to have_field(I18n.t('activerecord.attributes.offer.comment'))
        end

        scenario('fiels are required') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.deny')
            end

            click_on I18n.t('views.main.send')

            # Assert
            expect(page).to have_content(I18n.t('errors.messages.blank'), count: 1)
        end

        scenario('with success') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.deny')
            end

            fill_in I18n.t('activerecord.attributes.offer.comment'), with: 'Valor pedido pelo candidato está acima do mercado'
            click_on I18n.t('views.main.send')

            # Assert
            expect(current_path).to eq(application_list_opportunity_path(@submission.opportunity.id))
        end

        scenario('the candidate status is updated') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.deny')
            end

            fill_in I18n.t('activerecord.attributes.offer.comment'), with: 'Valor pedido pelo candidato está acima do mercado'
            click_on I18n.t('views.main.send')

            # Assert
            within("div#submission_#{@submission.id}") do
                expect(page).to have_content(I18n.t('activerecord.attributes.submission.status_denied'))
            end
        end

        scenario('can\'t appreciate again') do
            # Arrange
            login_as @admin_user 

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.opportunities.mine')
            end

            click_on @opportunity.title
            click_on @candidate_profile.name
            within("div#submission_#{@submission.id}") do
                click_on I18n.t('views.offers.deny')
            end

            fill_in I18n.t('activerecord.attributes.offer.comment'), with: 'Valor pedido pelo candidato está acima do mercado'
            click_on I18n.t('views.main.send')

            # Assert
            within("div#submission_#{@submission.id}") do
                expect(page).not_to have_link(I18n.t('views.offers.accept'))
                expect(page).not_to have_link(I18n.t('views.offers.deny'))
            end
        end

    end

end
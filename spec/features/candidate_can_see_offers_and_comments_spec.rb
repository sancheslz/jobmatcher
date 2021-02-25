require 'rails_helper'

feature('Candidate can see offers and comments') do

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

    context('accepted submissions') do

        scenario('link shows offer') do
            # Arrange
            @offer = Offer.create!(
                submission: @submission,
                profile: @admin_user.profile,
                comment: 'Muito bom',
                salary: 3000,
                start_at: 10.days.from_now
            )

            @submission.update(status: :accepted)
            @submission.save

            login_as @candidate_user

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.submissions.mine')
            end
            click_on @submission.opportunity.title

            # Assert
            expect(current_path).to eq(offer_path(@offer))
        end

        scenario('see the offer content') do
            # Arrange
            @offer = Offer.create!(
                submission: @submission,
                profile: @admin_user.profile,
                comment: 'Muito bom',
                salary: 3000,
                start_at: 10.days.from_now
            )

            @submission.update(status: :accepted)
            @submission.save

            login_as @candidate_user

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.submissions.mine')
            end
            click_on @submission.opportunity.title

            # Assert
            expect(page).to have_content(@offer.comment) 
            expect(page).to have_content(@offer.start_at.strftime('%d/%m/%Y')) 
        end

    end

    context('denied submissions') do
        
        scenario('link shows offer') do
            # Arrange
            @offer = Offer.create!(
                submission: @submission,
                profile: @admin_user.profile,
                comment: 'Muito bom',
                salary: 3000,
                start_at: 10.days.from_now
            )

            @submission.update(status: :denied)
            @submission.save

            login_as @candidate_user

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.submissions.mine')
            end
            click_on @submission.opportunity.title

            # Assert
            expect(current_path).to eq(offer_path(@offer))
        end

        scenario('see the offer content') do
            # Arrange
            @offer = Offer.create!(
                submission: @submission,
                profile: @admin_user.profile,
                comment: 'Muito bom',
                salary: 3000,
                start_at: 10.days.from_now
            )

            @submission.update(status: :denied)
            @submission.save

            login_as @candidate_user

            # Act
            visit root_path 
            within('nav') do
                click_on 'Menu'
                click_on I18n.t('views.submissions.mine')
            end
            click_on @submission.opportunity.title

            # Assert
            expect(page).to have_content(@offer.comment) 
        end


    end
end
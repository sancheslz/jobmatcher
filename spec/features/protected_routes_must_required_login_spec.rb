require 'rails_helper'

feature('Protected routes must require login') do
    context('Company') do
        
        scenario('#new') do
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
            visit new_company_path 

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario('#edit') do
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
            visit edit_company_path(company)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario('#change_state') do
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
            visit change_state_company_path(company)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

    end
    
    context("Profile")do

        scenario('#show') do
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

            # Act 
            visit profile_path(profile)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario('#new') do
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

            # Act 
            visit new_profile_path

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario('#edit') do
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

            # Act 
            visit edit_profile_path(profile)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end
        
    end

    context('Technology') do

        scenario('#index') do
            # Arrange
            technology = Technology.create!( name: 'JavaScript' )

            # Act
            visit technologies_path

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario('#new') do
            # Arrange
            technology = Technology.create!( name: 'JavaScript' )

            # Act
            visit new_technology_path

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario('#edit') do
            # Arrange
            technology = Technology.create!( name: 'JavaScript' )

            # Act
            visit edit_technology_path(technology)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end
        
    end

    context("Opportunity") do

        scenario("#index") do
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
            visit opportunities_path

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario("#new") do
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
            visit new_opportunity_path

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario("#edit") do
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
            visit edit_opportunity_path(opportunity)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario("#change_visibility") do
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
            visit change_visibility_opportunity_path(opportunity)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario("#application_list") do
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
            visit application_list_opportunity_path(opportunity)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario("#application_detail") do
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

            submission = Submission.create!(
                profile: profile,
                opportunity: opportunity,
                wage_claim: 7900,
                note: '',
                presentation: %{Tenho 10 anos de experiência como Engenheiro de Produção em uma empresa de grande porte, atuei no controle logístico, de produção e gerência. Estou em transição de carreira para a área de desenvolvimento de software. Tenho experiência com JavaScript, React, Angular, Vue e PHP},
                status: :removed
            )

            # Act
            visit application_detail_opportunity_path(submission)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end
    end
    
    context("Submission") do
        scenario("#new") do
            # Arrange
            # Act
            visit new_submission_path

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end

        scenario("#remove") do
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
            company = Company.create!(
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
            opportunity = Opportunity.create!(
                title: "Programador(a) PHP",
                description: %{Desenvolvimento e manutenção de aplicações web | Realizar a manutenção e criação de novas funcionalidades | Desenvolvimento de funcionalidades no Back-End | Aplicar melhores práticas de documentação de código desenvolvido},
                requirement: %{Formação em ensino superior ou técnico | Experiência prévia nas linguagens informadas | Habilidades interpessoais de escrita e de comunicação verbal},
                position_quantity: 2,
                expiration_date: 30.days.from_now,
                salary: 2000,
                remote: false,
                level: :entry,
                company: company,
                is_visible: true,
            )
            submission = Submission.create!(
                profile: profile,
                opportunity: opportunity,
                wage_claim: 2500,
                note: '',
                presentation: %{Tenho 10 anos de experiência como Engenheiro de Produção em uma empresa de grande porte, atuei no controle logístico, de produção e gerência. Estou em transição de carreira para a área de desenvolvimento de software. Tenho experiência com JavaScript, React, Angular, Vue e PHP},
                status: :applied
            )

            # Act
            visit remove_submission_path(submission)

            # Assert
            expect(current_path).to eq(new_user_session_path)
        end
    end

end
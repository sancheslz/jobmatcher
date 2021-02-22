require 'rails_helper'

feature('Admin routes are protected') do

    context('regular user can\'t access') do
        scenario('technology#index') do
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
            visit technologies_path

            # Assert
            expect(current_path).to eq(root_path)
        end

        scenario('technology#new') do
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
            visit new_technology_path

            # Assert
            expect(current_path).to eq(root_path)
        end

        scenario('technology#edit') do
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

            technology = Technology.create!( name: 'JavaScript' )
            
            login_as user

            # Act
            visit edit_technology_path(technology)

            # Assert
            expect(current_path).to eq(root_path)
        end

        scenario('company#new') do
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

            technology = Technology.create!( name: 'JavaScript' )
            
            login_as user

            # Act
            visit new_company_path

            # Assert
            expect(current_path).to eq(root_path)
        end

        scenario('company#edit') do
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
            
            
            login_as user

            # Act
            visit edit_company_path(company)

            # Assert
            expect(current_path).to eq(root_path)
        end

        scenario('company#change_state') do
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
            
            
            login_as user

            # Act
            visit change_state_company_path(company)

            # Assert
            expect(current_path).to eq(root_path)
        end

        scenario('opportunity#new') do
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
            
            
            login_as user

            # Act
            visit new_opportunity_path 

            # Assert
            expect(current_path).to eq(root_path)
        end


        scenario('opportunity#edit') do
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
            
            
            login_as user

            # Act
            visit edit_opportunity_path(opportunity)

            # Assert
            expect(current_path).to eq(root_path)
        end


        scenario('opportunity#change_visibility') do
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
            
            
            login_as user

            # Act
            visit change_visibility_opportunity_path(opportunity)

            # Assert
            expect(current_path).to eq(root_path)
        end


    end

    context('admin can see only his own company') do

        scenario('company#edit') do
            # Arrange       
            owner_user = User.create!(
                email: 'graciliana.novaes@cdev.com',
                password: 'brownbird755'
            )

            owner_profile = Profile.create!(
                name: 'Graciliana Novaes',
                cpf: '388.586.242-26',
                address: 'Rua Quatro',
                number: '8229',
                complement: '-', 
                city: 'Resende',
                state: 'Roraima', 
                postal_code: '75674',
                role: 'admin',
                user: owner_user
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
            
            company_profile = CompanyProfile.create!(
                profile: owner_profile,
                company: company, 
            )    
            
            
            user = User.create!(
                email: 'linton.araujos@moemasoft.com',
                password: 'crazybutterfly906'
            )

            profile = Profile.create!(
                name: 'Línton Araújo',
                cpf: '280.720.644-08',
                address: 'Rua Doze',
                number: '8',
                complement: 'Park',
                city: 'Caxias',
                state: 'Alagoas',
                postal_code: '88870',
                role: 'admin',
                user: user
            )

            user_company = Company.create!(
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

            company_profile = CompanyProfile.create!(
                profile: profile,
                company: user_company, 
            )
            
            login_as user

            # Act
            visit edit_company_path(company)

            # Assert
            expect(current_path).to eq(root_path)
        end

        scenario('company#change_state') do
            # Arrange       
            owner_user = User.create!(
                email: 'graciliana.novaes@cdev.com',
                password: 'brownbird755'
            )

            owner_profile = Profile.create!(
                name: 'Graciliana Novaes',
                cpf: '388.586.242-26',
                address: 'Rua Quatro',
                number: '8229',
                complement: '-', 
                city: 'Resende',
                state: 'Roraima', 
                postal_code: '75674',
                role: 'admin',
                user: owner_user
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
            
            company_profile = CompanyProfile.create!(
                profile: owner_profile,
                company: company, 
            )    
            
            
            user = User.create!(
                email: 'linton.araujos@moemasoft.com',
                password: 'crazybutterfly906'
            )

            profile = Profile.create!(
                name: 'Línton Araújo',
                cpf: '280.720.644-08',
                address: 'Rua Doze',
                number: '8',
                complement: 'Park',
                city: 'Caxias',
                state: 'Alagoas',
                postal_code: '88870',
                role: 'admin',
                user: user
            )

            user_company = Company.create!(
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

            company_profile = CompanyProfile.create!(
                profile: profile,
                company: user_company, 
            )
            
            login_as user

            # Act
            visit change_state_company_path(company)

            # Assert
            expect(current_path).to eq(root_path)
        end
    end

    scenario('only the candidate can cancel his submission') do
        # Arrange
        owner_user = User.create!(
            email: 'felismino.daconceicao@gmail.com',
            password: 'yellowtiger502'
        )

        onwer_profile = Profile.create!(
            name: 'Felismino da Conceição',
            cpf: '175.113.263-01',
            address: 'Rua Treze de Maio',
            number: '7971',
            complement: 'C12', 
            city: 'Nossa Senhora do Socorro',
            state: 'Espírito Santo', 
            postal_code: '84373',
            role: 'regular',
            user: owner_user
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

        submissison = Submission.create!(
            profile: onwer_profile,
            opportunity: opportunity,
            wage_claim: 7900,
            note: '',
            presentation: %{Tenho 10 anos de experiência como Engenheiro de Produção em uma empresa de grande porte, atuei no controle logístico, de produção e gerência. Estou em transição de carreira para a área de desenvolvimento de software. Tenho experiência com JavaScript, React, Angular, Vue e PHP},
            status: :applied
        )

        user = User.create!(
            email: 'genoveva.dacunhae@gmail.com',
            password: 'yellowtiger502'
        )

        profile = Profile.create!(
            name: 'Genoveva da Cunha',
            cpf: '898.791.029-74',
            address: 'Rua Dois',
            number: '983',
            complement: 'Court',
            city: 'Mauá',
            state: 'Paraná',
            postal_code: '54368',
            role: 'regular',
            user: user
        )

        login_as user

        # Act
        visit remove_submission_path(submissison) 

        # Assert
        expect(current_path).to eq(root_path)
    end
end